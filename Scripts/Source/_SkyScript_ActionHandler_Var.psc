scriptName _SkyScript_ActionHandler_Var extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("var")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string varName = GetString(actioninfo, "var")
    if JMap.hasKey(actionInfo, "value")
        int valueType = JMap.valueType(actionInfo, "value")
        if valueType == 2 ; Int
            SkyScript.SetVariableInt(scriptInstance, varName, JMap.getInt(actionInfo, "value"))
        elseIf valueType == 3 ; Float
            SkyScript.SetVariableFloat(scriptInstance, varName, JMap.getFlt(actionInfo, "value"))
        elseIf valueType == 4 ; Form
            SkyScript.SetVariableForm(scriptInstance, varName, JMap.getForm(actionInfo, "value"))
        elseIf valueType == 5 ; Object
            SkyScript.SetVariableObject(scriptInstance, varName, JMap.getObj(actionInfo, "value"))
        elseIf valueType == 6 ; String
            SkyScript.SetVariableString(scriptInstance, varName, JMap.getStr(actionInfo, "value"))
        endIf
    endIf
endFunction