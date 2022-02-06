scriptName _SkyScript_ScriptInstance hidden

int function InitializeFromFile(string filepath) global
    if MiscUtil.FileExists(filepath)
        int actionsFromFile = JValue.readFromFile(filepath)
        if actionsFromFile
            if JValue.isArray(actionsFromFile)
                int scriptInstance = Initialize()
                SetActionArray(scriptInstance, actionsFromFile)
                SetFilepath(scriptInstance, filepath)
                return scriptInstance
            elseIf JValue.isMap(actionsFromFile) || JValue.isIntegerMap(actionsFromFile) || JValue.isFormMap(actionsFromFile)
                int scriptInstance = Initialize()
                int actionArray = JArray.object()
                JArray.addObj(actionArray, actionsFromFile)
                SetActionArray(scriptInstance, actionArray)
                SetFilepath(scriptInstance, filepath)
                return scriptInstance
            endIf
        endIf
    endIf
    return 0
endFunction

int function Initialize() global
    int scriptInstance = JMap.object()
    JMap.setObj(_RunningScriptInstances(), scriptInstance, scriptInstance)
    JMap.setObj(scriptInstance, "variables", JMap.object())
    JMap.setObj(scriptInstance, "actionSubscripts", JMap.object())
    return scriptInstance
endFunction

function Dispose(int scriptInstance) global
    JMap.removeKey(_RunningScriptInstances(), scriptInstance)
endFunction

function AddAndRunActionSubScript(int scriptInstance, int actionInfo, int subscriptActions) global
    int subscriptInstance = AddActionSubScript(scriptInstance, actionInfo, subscriptActions)
    _SkyScript_Runner.ResumeScriptInstance(subscriptInstance)
    if ! SkyScript.IsPaused(subscriptInstance)
        Dispose(subscriptInstance)
    endIf
endFunction

int function AddActionSubScript(int scriptInstance, int actionInfo, int subscriptActions) global
    int map = GetActionToSubScriptMap(scriptInstance)
    int subscriptInstance = _SkyScript_ScriptInstance.Initialize()
    JMap.setObj(map, actionInfo, subscriptInstance)
    SetParent(subscriptInstance, scriptInstance)
    _SkyScript_ScriptInstance.SetActionArray(subscriptInstance, subscriptActions)
    return subscriptInstance
endFunction

function MarkAsRunning(int scriptInstance) global
    JMap.setInt(scriptInstance, "running", 1)
endFunction

function MarkAsNotRunning(int scriptInstance) global
    JMap.setInt(scriptInstance, "running", 0)
endFunction

bool function IsRunning(int scriptInstance) global
    return JMap.getInt(scriptInstance, "running")
endFunction

function Pause(int scriptInstance) global
    JMap.setInt(scriptInstance, "paused", 1)
endFunction

bool function IsPaused(int scriptInstance) global
    int parent = GetParent(scriptInstance)
    return JMap.getInt(scriptInstance, "paused") || (parent && IsPaused(parent))
endFunction

int function Run(int scriptInstance) global
    return Resume(scriptInstance)
endFunction

int function Resume(int scriptInstance) global
    JMap.setInt(scriptInstance, "paused", 0)
    return _SkyScript_Runner.ResumeScriptInstance(scriptInstance)
endFunction

function Kill(int scriptInstance) global
    if IsRunning(scriptInstance) && (! IsPaused(scriptInstance))
        JMap.setInt(scriptInstance, "killed", 1)
    else
        Dispose(scriptInstance)
    endIf
endFunction

bool function IsMarkedToBeKilled(int scriptInstance) global
    return JMap.getInt(scriptInstance, "killed")
endFunction

int function Get(int scriptInstance) global
    return JMap.getObj(_RunningScriptInstances(), scriptInstance)
endFunction

string function GetFilepath(int scriptInstance) global
    return JMap.getStr(scriptInstance, "filepath")
endFunction

function SetFilepath(int scriptInstance, string filepath) global
    JMap.setStr(scriptInstance, "filepath", filepath)
    SetVariableString(scriptInstance, "SCRIPT_FILENAME", filepath)
endFunction

int function GetActionArray(int scriptInstance) global
    return JMap.getObj(scriptInstance, "actions")
endFunction

function SetCurrentActionIndex(int scriptInstance, int actionIndex) global
    JMap.setInt(scriptInstance, "currentActionIndex", actionIndex)
endFunction

int function GetCurrentActionIndex(int scriptInstance) global
    return JMap.getInt(scriptInstance, "currentActionIndex")
endFunction

function SetActionArray(int scriptInstance, int actionArray) global
    if JValue.isArray(actionArray)
        JMap.setObj(scriptInstance, "actions", actionArray)
    elseIf actionArray
        int actionsArray = JArray.object()
        JArray.addObj(actionsArray, actionArray)
        JMap.setObj(scriptInstance, "actions", actionsArray)
    endIf
endFunction

function SetParent(int scriptInstance, int parentInstance) global
    JMap.setObj(scriptInstance, "parent", parentInstance)
endFunction

int function GetParent(int scriptInstance) global
    return JMap.getObj(scriptInstance, "parent")
endFunction

int function GetVariableMap(int scriptInstance) global
    return JMap.getObj(scriptInstance, "variables")
endFunction

int function GetSubScriptInstanceForAction(int scriptInstance, int actionInfo) global
    return JMap.getObj(GetActionToSubScriptMap(scriptInstance), actionInfo)
endFunction

int function GetActionToSubScriptMap(int scriptInstance) global
    return JMap.getObj(scriptInstance, "actionSubscripts")
endFunction

int function _RunningScriptInstances() global
    return _SkyScript_Data.FindOrCreateMap("scripts")
endFunction

int function DeclareVariable(int scriptInstance, string name) global
    int varMap = GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return JMap.getObj(varMap, name)
    else
        int variable = JMap.object()
        JMap.setObj(varMap, name, variable)
        return variable
    endIf
endFunction

bool function VarExists(int scriptInstance, string name) global
    int varMap = GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return true
    endIf
    int parent = GetParent(scriptInstance)
    if parent
        return VarExists(parent, name)
    else
        return false
    endIf
endFunction

; TODO - update this whole damn this to not call GetVariable() again and again
int function GetVariable(int scriptInstance, string name) global
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
        if GetVariableType(scriptInstance, variableName) == "form"
            return GetFormPropertyVariable(GetVariableForm(scriptInstance, variableName), subVariableName)
        else
            int object = GetVariableObject(scriptInstance, variableName)
            return GetObjectSubvariable(object, subVariableName)
        endIf
    else
        int varMap = GetVariableMap(scriptInstance)
        if JMap.hasKey(varMap, name)
            return JMap.getObj(varMap, name)
        endIf
        int parent = GetParent(scriptInstance)
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
        JMap.setStr(variable, "value", theForm.GetName())
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

string function GetVariableType(int scriptInstance, string name) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getStr(variable, "type")
    else
        return ""
    endIf
endFunction

int function GetVariableInt(int scriptInstance, string name, int default = 0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getInt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableInt(int scriptInstance, string name, int value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "int")
    JMap.removeKey(variable, "value")
    JMap.setInt(variable, "value", value)
endFunction

float function GetVariableFloat(int scriptInstance, string name, float default = 0.0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getFlt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableFloat(int scriptInstance, string name, float value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "float")
    JMap.removeKey(variable, "value")
    JMap.setFlt(variable, "value", value)
endFunction

string function GetVariableString(int scriptInstance, string name, string default = "") global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getStr(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableString(int scriptInstance, string name, string value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "string")
    JMap.removeKey(variable, "value")
    JMap.setStr(variable, "value", value)
endFunction

Form function GetVariableForm(int scriptInstance, string name, Form default = None) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getForm(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableForm(int scriptInstance, string name, Form value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "Form")
    JMap.removeKey(variable, "value")
    JMap.setForm(variable, "value", value)
endFunction

int function GetVariableObject(int scriptInstance, string name, int default = 0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getObj(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableObject(int scriptInstance, string name, int value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "object")
    JMap.removeKey(variable, "value")
    JMap.setObj(variable, "value", value)
endFunction

string function GetVariableText(int scriptInstance, string name) global
    string variableType = GetVariableType(scriptInstance, name)
    if variableType
        if variableType == "object"
            return "OBJECT: " + ToJson(GetVariableObject(scriptInstance, name))
        elseIf variableType == "string"
            return GetVariableString(scriptInstance, name)
        elseIf variableType == "int"
            return GetVariableInt(scriptInstance, name)
        elseIf variableType == "float"
            return GetVariableFloat(scriptInstance, name)
        elseIf variableType == "form"
            return GetVariableForm(scriptInstance, name)
        else
            return "UNSUPPORTED VAR TYPE: " + variableType
        endIf
    else
        return ""
    endIf
endFunction

; TODO find a new home for this function
string function ToJson(int object) global
    if object
        string tempFile = _SkyScript_Files.GetTempFile()
        JValue.writeToFile(object, tempFile)
        string json = MiscUtil.ReadFromFile(tempFile)
        _SkyScript_Files.DeleteFile(tempFile)
        return json
    else
        return "[No object]"
    endIf
endFunction

string function InterpolateString(int scriptInstance, string text) global
    if ! text
        return ""
    endIf

    int varStart = StringUtil.Find(text, "${")
    while varStart > -1
        int varEnd = StringUtil.Find(text, "}", varStart)
        string varName = StringUtil.Substring(text, varStart + 2, (varEnd - varStart - 2))
        
        string beforeVar = ""
        if varStart > 0
            beforeVar = StringUtil.Substring(text, 0, varStart)
        endIf

        string afterVar = ""
        if varEnd != StringUtil.GetLength(text) - 1
            afterVar = StringUtil.Substring(text, varEnd + 1)
        endIf

        string variableText = GetVariableText(scriptInstance, varName)

        text = beforeVar + variableText + afterVar
        
        varStart = StringUtil.Find(text, "${")
    endWhile
    return text
endFunction
