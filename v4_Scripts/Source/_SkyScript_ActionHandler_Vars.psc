scriptName _SkyScript_ActionHandler_Vars extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("vars")
endEvent

int function Execute(int script, int actionInfo)
    int variableMap = GetObject(actionInfo, "vars")
    string[] variableNames = JMap.allKeysPArray(variableMap)
    int i = 0
    while i < variableNames.Length
        string variableName = variableNames[i]
        int variableType = JMap.valueType(variableMap, variableName)
        if variableType == 2 ; Int
            SkyScript.SetVariableInt(script, variableName, JMap.getInt(variableMap, variableName))
        elseIf variableType == 3 ; Float
            SkyScript.SetVariableFloat(script, variableName, JMap.getFlt(variableMap, variableName))
        elseIf variableType == 4 ; Form
            SkyScript.SetVariableForm(script, variableName, JMap.getForm(variableMap, variableName))
        elseIf variableType == 5 ; Object
            SkyScript.SetVariableObject(script, variableName, JMap.getObj(variableMap, variableName))
        elseIf variableType == 6 ; String
            SkyScript.SetVariableString(script, variableName, JMap.getStr(variableMap, variableName))
        endIf
        i += 1
    endWhile
endFunction
