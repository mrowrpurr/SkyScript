scriptName _SkyScript_ActionHandler_Equip extends SkyScriptActionHandler

string property EQUIP_KEY = "equip" autoReadonly
string property UNEQUIP_KEY = "unequip" autoReadonly

event RegisterSyntax()
    AddSyntax(EQUIP_KEY)
    AddSyntax(UNEQUIP_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    Actor target = GetActor(scriptInstance, actionInfo, "target", Player)

    if HasField(actionInfo, EQUIP_KEY)
        int object
        if IsString(actionInfo, EQUIP_KEY)
            string varName = GetString(actionInfo, EQUIP_KEY)
            if SkyScript.GetVariableType(scriptInstance, varName) == "object"
                object = SkyScript.GetVariableObject(scriptInstance, varName)
            endIf
        endIf
        if IsObject(actionInfo, EQUIP_KEY)
            object = GetObject(actionInfo, EQUIP_KEY)
            if ! JValue.isArray(object)
                object = RunAction(scriptInstance, object)
            endIf
        endIf
        if JValue.isArray(object)
            int count = JArray.count(object)
            int i = 0
            while i < count
                Form theForm = JArray.getForm(object, i)
                if theForm
                    target.EquipItem(theForm)
                endIf
                i += 1
            endWhile
        endIf
    elseif HasField(actionInfo, UNEQUIP_KEY)
        if IsString(actionInfo, UNEQUIP_KEY) && GetString(actionInfo, UNEQUIP_KEY) == "all"
            target.UnequipAll()
        endIf
    endIf 
endFunction
