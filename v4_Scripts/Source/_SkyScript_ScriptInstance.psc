scriptName _SkyScript_ScriptInstance hidden

int function InitializeFromFile(string filepath) global
    if MiscUtil.FileExists(filepath)
        int actionsFromFile = JValue.readFromFile(filepath)
        if actionsFromFile
            int script = InitializeFromObject(actionsFromFile)
            SetFilepath(script, filepath)
            return script
        endIf
    endIf
    return 0
endFunction

int function InitializeFromString(string json) global
    int object = JValue.objectFromPrototype(json)
    if object
        return InitializeFromObject(object)
    else
        return 0
    endIf
endFunction

int function InitializeFromObject(int object) global
    if JValue.isArray(object)
        int script = Initialize()
        SkyScript.SetScriptActions(script, object)
        return script
    elseIf JValue.isMap(object) || JValue.isIntegerMap(object) || JValue.isFormMap(object)
        int script = Initialize()
        int actionArray = JArray.object()
        JArray.addObj(actionArray, object)
        SkyScript.SetScriptActions(script, actionArray)
        return script
    endIf
endFunction

int function Initialize() global
    int script = JMap.object()
    JMap.setObj(_Runningscripts(), script, script)
    JMap.setObj(script, "variables", JMap.object())
    JMap.setObj(script, "actionSubscripts", JMap.object())
    return script
endFunction

function Dispose(int script) global
    JMap.removeKey(_Runningscripts(), script)
endFunction

function MarkAsRunning(int script) global
    JMap.setInt(script, "running", 1)
endFunction

function MarkAsNotRunning(int script) global
    JMap.setInt(script, "running", 0)
endFunction

bool function IsRunning(int script) global
    return JMap.getInt(script, "running")
endFunction

function Pause(int script) global
    JMap.setInt(script, "paused", 1)
endFunction

bool function IsPaused(int script) global
    int parent = SkyScript.GetScriptParent(script)
    return JMap.getInt(script, "paused") || (parent && IsPaused(parent))
endFunction

int function Run(int script) global
    return Resume(script)
endFunction

int function Resume(int script) global
    JMap.setInt(script, "paused", 0)
    return _SkyScript_Runner.Resumescript(script)
endFunction

function Kill(int script) global
    if IsRunning(script) && (! IsPaused(script))
        JMap.setInt(script, "killed", 1)
    else
        Dispose(script)
    endIf
endFunction

bool function IsMarkedToBeKilled(int script) global
    return JMap.getInt(script, "killed")
endFunction

int function Get(int script) global
    return JMap.getObj(_Runningscripts(), script)
endFunction

string function GetFilepath(int script) global
    return JMap.getStr(script, "filepath")
endFunction

function SetFilepath(int script, string filepath) global
    JMap.setStr(script, "filepath", filepath)
    SkyScript.SetVariableString(script, "SCRIPT_FILENAME", filepath)
endFunction

int function GetActionArray(int script) global
    return JMap.getObj(script, "actions")
endFunction

function SetCurrentActionIndex(int script, int actionIndex) global
    JMap.setInt(script, "currentActionIndex", actionIndex)
endFunction

int function GetCurrentActionIndex(int script) global
    return JMap.getInt(script, "currentActionIndex")
endFunction

int function GetVariableMap(int script) global
    return JMap.getObj(script, "variables")
endFunction

int function GetSubscriptForAction(int script, int actionInfo) global
    return JMap.getObj(GetActionToSubScriptMap(script), actionInfo)
endFunction

int function GetActionToSubScriptMap(int script) global
    return JMap.getObj(script, "actionSubscripts")
endFunction

int function _Runningscripts() global
    return _SkyScript_Data.FindOrCreateMap("scripts")
endFunction

function AddAndRunActionSubScript(int script, int actionInfo, int subscriptActions) global
    int subscript = AddActionSubScript(script, actionInfo, subscriptActions)
    _SkyScript_Runner.Resumescript(subscript)
    if ! SkyScript.IsPaused(subscript)
        Dispose(subscript)
    endIf
endFunction

int function AddActionSubScript(int script, int actionInfo, int subscriptActions) global
    int map = _SkyScript_ScriptInstance.GetActionToSubScriptMap(script)
    int subscript = _SkyScript_ScriptInstance.Initialize()
    JMap.setObj(map, actionInfo, subscript)
    SkyScript.SetScriptParent(subscript, script)
    SkyScript.SetScriptActions(subscript, subscriptActions)
    return subscript
endFunction

; TODO - update this whole damn this to not call GetVariable() again and again
int function GetVariable(int script, string name) global
    if StringUtil.Find(name, ".") > -1
        string[] variableParts = StringUtil.Split(name, ".")
        string variableName = variableParts[0]
        string subVariableName = ""
        int i = 1
        while i < variableParts.Length
            if i == 1
                subVariableName += variableParts[i]
            else
                subVariableName += "." + variableParts[i]
            endIf
            i += 1
        endWhile
        if SkyScript.GetVariableType(script, variableName) == "form"
            return GetFormPropertyVariable(SkyScript.GetVariableForm(script, variableName), subVariableName)
        else
            int object = SkyScript.GetVariableObject(script, variableName)
            return GetObjectSubvariable(object, subVariableName)
        endIf
    else
        int varMap = GetVariableMap(script)
        if JMap.hasKey(varMap, name)
            return JMap.getObj(varMap, name)
        endIf
        int parent = SkyScript.GetScriptParent(script)
        if parent
            return GetVariable(parent, name)
        else
            return 0
        endIf
    endIf
endFunction

int function GetObjectSubvariable(int object, string subVariableName) global
    ; What type of object is this?

    if StringUtil.Find(subVariableName, ".") > -1
        string[] variableParts = StringUtil.Split(subVariableName, ".")
        string variableName = variableParts[0]
        string newSubVariableName = ""
        int i = 1
        while i < variableParts.Length
            if i == 1
                newSubVariableName += variableParts[i]
            else
                newSubVariableName += "." + variableParts[i]
            endIf
            i += 1
        endWhile
        if JMap.valueType(object, variableName) == 4 ; Form
            return GetFormPropertyVariable(JMap.getForm(object, variableName), newSubVariableName)
        else
            int subobject = JMap.getObj(object, variableName)
            return GetObjectSubvariable(subobject, newSubVariableName)
        endIf
    else
        if JMap.hasKey(object, subVariableName)
            int variable = JMap.object()
            int valueType = JMap.valueType(object, subVariableName)
            if valueType == 2 ; Int
                JMap.setStr(variable, "type", "int")
                JMap.setInt(variable, "value", JMap.getInt(object, subVariableName))
            elseIf valueType == 3 ; Float
                JMap.setStr(variable, "type", "float")
                JMap.setFlt(variable, "value", JMap.getFlt(object, subVariableName))
            elseIf valueType == 4 ; Form
                JMap.setStr(variable, "type", "form")
                JMap.setForm(variable, "value", JMap.getForm(object, subVariableName))
            elseIf valueType == 5 ; Object
                JMap.setStr(variable, "type", "object")
                JMap.setObj(variable, "value", JMap.getObj(object, subVariableName))
            elseIf valueType == 6 ; String
                JMap.setStr(variable, "type", "string")
                JMap.setStr(variable, "value", JMap.getStr(object, subVariableName))
            endIf
            return variable
        else
            return 0
        endIf
    endIf
endFunction

int function GetFormPropertyVariable(Form theForm, string propertyName) global
    ; TODO - make this extensible! and based on various types! woohoo!
    int variable = JMap.object()
    if propertyName == "name"
        JMap.setStr(variable, "type", "string")
        if theForm as Actor
            JMap.setStr(variable, "value", (theForm as Actor).GetActorBase().GetName())
        else
            JMap.setStr(variable, "value", theForm.GetName())
        endIf
    elseIf propertyName == "type"
        JMap.setStr(variable, "type", "string")
        JMap.setStr(variable, "value", GetFormTypeName(theForm))
    else
        JMap.setStr(variable, "type", "string")
        JMap.setStr(variable, "value", "Unsupported Form property: " + propertyName)
    endIf
    return variable
endFunction

; TODO move to a helper for forms!
string function GetFormTypeName(Form theForm) global
    if theForm
        int formTypeId = theForm.GetType()
        if formTypeId == 83
            return "ANIO"
        elseIf formTypeId == 102
            return "ARMA"
        elseIf formTypeId == 16
            return "AcousticSpace"
        elseIf formTypeId == 6
            return "Action"
        elseIf formTypeId == 24
            return "Activator"
        elseIf formTypeId == 95
            return "ActorValueInfo"
        elseIf formTypeId == 94
            return "AddonNode"
        elseIf formTypeId == 42
            return "Ammo"
        elseIf formTypeId == 33
            return "Apparatus"
        elseIf formTypeId == 26
            return "Armor"
        elseIf formTypeId == 64
            return "ArrowProjectile"
        elseIf formTypeId == 125
            return "Art"
        elseIf formTypeId == 123
            return "AssociationType"
        elseIf formTypeId == 69
            return "BarrierProjectile"
        elseIf formTypeId == 66
            return "BeamProjectile"
        elseIf formTypeId == 93
            return "BodyPartData"
        elseIf formTypeId == 27
            return "Book"
        elseIf formTypeId == 97
            return "CameraPath"
        elseIf formTypeId == 96
            return "CameraShot"
        elseIf formTypeId == 60
            return "Cell"
        elseIf formTypeId == 62
            return "Character"
        elseIf formTypeId == 10
            return "Class"
        elseIf formTypeId == 55
            return "Climate"
        elseIf formTypeId == 132
            return "CollisionLayer"
        elseIf formTypeId == 133
            return "ColorForm"
        elseIf formTypeId == 80
            return "CombatStyle"
        elseIf formTypeId == 68
            return "ConeProjectile"
        elseIf formTypeId == 49
            return "ConstructibleObject"
        elseIf formTypeId == 28
            return "Container"
        elseIf formTypeId == 117
            return "DLVW"
        elseIf formTypeId == 88
            return "Debris"
        elseIf formTypeId == 107
            return "DefaultObject"
        elseIf formTypeId == 115
            return "DialogueBranch"
        elseIf formTypeId == 29
            return "Door"
        elseIf formTypeId == 129
            return "DualCastData"
        elseIf formTypeId == 18
            return "EffectSetting"
        elseIf formTypeId == 85
            return "EffectShader"
        elseIf formTypeId == 21
            return "Enchantment"
        elseIf formTypeId == 103
            return "EncounterZone"
        elseIf formTypeId == 120
            return "EquipSlot"
        elseIf formTypeId == 87
            return "Explosion"
        elseIf formTypeId == 13
            return "Eyes"
        elseIf formTypeId == 11
            return "Faction"
        elseIf formTypeId == 67
            return "FlameProjectile"
        elseIf formTypeId == 39
            return "Flora"
        elseIf formTypeId == 110
            return "Footstep"
        elseIf formTypeId == 111
            return "FootstepSet"
        elseIf formTypeId == 40
            return "Furniture"
        elseIf formTypeId == 3
            return "GMST"
        elseIf formTypeId == 9
            return "Global"
        elseIf formTypeId == 37
            return "Grass"
        elseIf formTypeId == 65
            return "GrenadeProjectile"
        elseIf formTypeId == 2
            return "Group"
        elseIf formTypeId == 51
            return "Hazard"
        elseIf formTypeId == 12
            return "HeadPart"
        elseIf formTypeId == 78
            return "Idle"
        elseIf formTypeId == 47
            return "IdleMarker"
        elseIf formTypeId == 89
            return "ImageSpace"
        elseIf formTypeId == 90
            return "ImageSpaceModifier"
        elseIf formTypeId == 100
            return "ImpactData"
        elseIf formTypeId == 101
            return "ImpactDataSet"
        elseIf formTypeId == 30
            return "Ingredient"
        elseIf formTypeId == 45
            return "Key"
        elseIf formTypeId == 4
            return "Keyword"
        elseIf formTypeId == 72
            return "Land"
        elseIf formTypeId == 20
            return "LandTexture"
        elseIf formTypeId == 44
            return "LeveledCharacter"
        elseIf formTypeId == 53
            return "LeveledItem"
        elseIf formTypeId == 82
            return "LeveledSpell"
        elseIf formTypeId == 31
            return "Light"
        elseIf formTypeId == 108
            return "LightingTemplate"
        elseIf formTypeId == 91
            return "List"
        elseIf formTypeId == 81
            return "LoadScreen"
        elseIf formTypeId == 104
            return "Location"
        elseIf formTypeId == 5
            return "LocationRef"
        elseIf formTypeId == 126
            return "Material"
        elseIf formTypeId == 99
            return "MaterialType"
        elseIf formTypeId == 8
            return "MenuIcon"
        elseIf formTypeId == 105
            return "Message"
        elseIf formTypeId == 32
            return "Misc"
        elseIf formTypeId == 63
            return "MissileProjectile"
        elseIf formTypeId == 36
            return "MovableStatic"
        elseIf formTypeId == 127
            return "MovementType"
        elseIf formTypeId == 116
            return "MusicTrack"
        elseIf formTypeId == 109
            return "MusicType"
        elseIf formTypeId == 59
            return "NAVI"
        elseIf formTypeId == 43
            return "NPC"
        elseIf formTypeId == 73
            return "NavMesh"
        elseIf formTypeId == 0
            return "None"
        elseIf formTypeId == 48
            return "Note"
        elseIf formTypeId == 124
            return "Outfit"
        elseIf formTypeId == 70
            return "PHZD"
        elseIf formTypeId == 79
            return "Package"
        elseIf formTypeId == 92
            return "Perk"
        elseIf formTypeId == 46
            return "Potion"
        elseIf formTypeId == 50
            return "Projectile"
        elseIf formTypeId == 77
            return "Quest"
        elseIf formTypeId == 14
            return "Race"
        elseIf formTypeId == 106
            return "Ragdoll"
        elseIf formTypeId == 61
            return "Reference"
        elseIf formTypeId == 57
            return "ReferenceEffect"
        elseIf formTypeId == 58
            return "Region"
        elseIf formTypeId == 121
            return "Relationship"
        elseIf formTypeId == 134
            return "ReverbParam"
        elseIf formTypeId == 122
            return "Scene"
        elseIf formTypeId == 19
            return "Script"
        elseIf formTypeId == 23
            return "ScrollItem"
        elseIf formTypeId == 56
            return "ShaderParticleGeometryData"
        elseIf formTypeId == 119
            return "Shout"
        elseIf formTypeId == 17
            return "Skill"
        elseIf formTypeId == 52
            return "SoulGem"
        elseIf formTypeId == 15
            return "Sound"
        elseIf formTypeId == 130
            return "SoundCategory"
        elseIf formTypeId == 128
            return "SoundDescriptor"
        elseIf formTypeId == 131
            return "SoundOutput"
        elseIf formTypeId == 22
            return "Spell"
        elseIf formTypeId == 34
            return "Static"
        elseIf formTypeId == 35
            return "StaticCollection"
        elseIf formTypeId == 112
            return "StoryBranchNode"
        elseIf formTypeId == 114
            return "StoryEventNode"
        elseIf formTypeId == 113
            return "StoryQuestNode"
        elseIf formTypeId == 1
            return "TES4"
        elseIf formTypeId == 74
            return "TLOD"
        elseIf formTypeId == 86
            return "TOFT"
        elseIf formTypeId == 25
            return "TalkingActivator"
        elseIf formTypeId == 7
            return "TextureSet"
        elseIf formTypeId == 75
            return "Topic"
        elseIf formTypeId == 76
            return "TopicInfo"
        elseIf formTypeId == 38
            return "Tree"
        elseIf formTypeId == 98
            return "VoiceType"
        elseIf formTypeId == 84
            return "Water"
        elseIf formTypeId == 41
            return "Weapon"
        elseIf formTypeId == 54
            return "Weather"
        elseIf formTypeId == 118
            return "WordOfPower"
        elseIf formTypeId == 71
            return "WorldSpace"
        endIf
    else
        return "None"
    endIf
endFunction
