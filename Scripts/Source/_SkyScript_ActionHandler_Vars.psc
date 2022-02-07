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
            SkyScript.SetVariableInt(scriptInstance, variableName, JMap.getInt(variableMap, variableName))
        elseIf variableType == 3 ; Float
            SkyScript.SetVariableFloat(scriptInstance, variableName, JMap.getFlt(variableMap, variableName))
        elseIf variableType == 4 ; Form
            SkyScript.SetVariableForm(scriptInstance, variableName, JMap.getForm(variableMap, variableName))
        elseIf variableType == 5 ; Object
            SkyScript.SetVariableObject(scriptInstance, variableName, JMap.getObj(variableMap, variableName))
        elseIf variableType == 6 ; String
            SkyScript.SetVariableString(scriptInstance, variableName, JMap.getStr(variableMap, variableName))
        endIf
        i += 1
    endWhile
endFunction
