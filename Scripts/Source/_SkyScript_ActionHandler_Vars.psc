scriptName _SkyScript_ActionHandler_Vars extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("vars")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    int variableMap = GetObject(actionInfo, "vars")
    string[] variableNames = JMap.allKeysPArray(variableMap)
    int i = 0
    while i < variableNames.Length
        string variableName = variableNames[i]
        int variableType = JMap.valueType(variableMap, variableName)
        if variableType == 2 ; Int
            _SkyScript_ScriptInstance.SetVariableInt(scriptInstance, variableName, JMap.getInt(variableMap, variableName))
        elseIf variableType == 3 ; Float
            _SkyScript_ScriptInstance.SetVariableFloat(scriptInstance, variableName, JMap.getFlt(variableMap, variableName))
        elseIf variableType == 4 ; Form
            _SkyScript_ScriptInstance.SetVariableForm(scriptInstance, variableName, JMap.getForm(variableMap, variableName))
        elseIf variableType == 5 ; Object
            _SkyScript_ScriptInstance.SetVariableObject(scriptInstance, variableName, JMap.getObj(variableMap, variableName))
        elseIf variableType == 6 ; String
            _SkyScript_ScriptInstance.SetVariableString(scriptInstance, variableName, JMap.getStr(variableMap, variableName))
        endIf
        i += 1
    endWhile
endFunction
