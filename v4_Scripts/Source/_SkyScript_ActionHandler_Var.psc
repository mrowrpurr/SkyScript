scriptName _SkyScript_ActionHandler_Var extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("var")
endEvent

int function Execute(int script, int actionInfo)
    string[] actionSyntaxKeys = JMap.allKeysPArray(actionInfo)

    ; Is it variable shorthand?
    if actionSyntaxKeys.Length == 1
        string keyName = actionSyntaxKeys[0]
        string varName
        if SkyScriptUtil.String_EndsWith(keyName, " =")
            varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 2)
        elseIf SkyScriptUtil.String_EndsWith(keyName, " = ")
            varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 3)
        endIf
        if varName
            ; The value of this key is a literal variable value
            int valueType = JMap.valueType(actionInfo, keyName)
            if valueType == 2 ; Int
                int value = JMap.getInt(actionInfo, keyName)
                SkyScript.SetVariableInt(script, varName, value)
                return ReturnInt(value)
            elseIf valueType == 3 ; Float
                float value = JMap.getFlt(actionInfo, keyName)
                SkyScript.SetVariableFloat(script, varName, value)
                return ReturnFloat(value)
            elseIf valueType == 4 ; Form
                Form value = JMap.getForm(actionInfo, keyName)
                SkyScript.SetVariableForm(script, varName, value)
                return ReturnForm(value)
            elseIf valueType == 5 ; Object
                int value = JMap.getObj(actionInfo, keyName)
                SkyScript.SetVariableObject(script, varName, value)
                return ReturnObject(value)
            elseIf valueType == 6 ; String
                string value = JMap.getStr(actionInfo, keyName)
                SkyScript.SetVariableString(script, varName, value)
                return ReturnString(value)
            endIf
        endIf
        if SkyScriptUtil.String_EndsWith(keyName, " =>") || SkyScriptUtil.String_EndsWith(keyName, " => ")
            if SkyScriptUtil.String_EndsWith(keyName, " =>")
                varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 3)
            elseIf SkyScriptUtil.String_EndsWith(keyName, " => ")
                varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 4)
            endIf
            ; The value of this key is an expression to be evaluated
            int expressionResponse
            int valueType = JMap.valueType(actionInfo, keyName)
            if valueType == 2 ; Int
                int value = JMap.getInt(actionInfo, keyName)
                SkyScript.SetVariableInt(script, varName, value)
                return ReturnInt(value)
            elseIf valueType == 3 ; Float
                float value = JMap.getFlt(actionInfo, keyName)
                SkyScript.SetVariableFloat(script, varName, value)
                return ReturnFloat(value)
            elseIf valueType == 4 ; Form
                Form value = JMap.getForm(actionInfo, keyName)
                SkyScript.SetVariableForm(script, varName, value)
                return ReturnForm(value)
            elseIf valueType == 5 ; Object
                int expressionAction = JMap.getObj(actionInfo, keyName)
                expressionResponse = _SkyScript_Runner.RunAction(script, expressionAction)
            elseIf valueType == 6 ; String
                string expressionText = JMap.getStr(actionInfo, keyName)
                expressionResponse = _SkyScript_Expressions.Evaluate(script, expressionText)
            endIf
            if expressionResponse
                string responseType = ResponseType(expressionResponse)
                if responseType == "bool"
                    SkyScript.SetVariableBool(script, varName, ResponseBool(expressionResponse))
                elseIf responseType == "int"
                    SkyScript.SetVariableInt(script, varName, ResponseInt(expressionResponse))
                elseIf responseType == "float"
                    SkyScript.SetVariableFloat(script, varName, ResponseFloat(expressionResponse))
                elseIf responseType == "form"
                    SkyScript.SetVariableForm(script, varName, ResponseForm(expressionResponse))
                elseIf responseType == "object"
                    SkyScript.SetVariableObject(script, varName, ResponseObject(expressionResponse))
                elseIf responseType == "string"
                    SkyScript.SetVariableString(script, varName, ResponseString(expressionResponse))
                endIf
                return expressionResponse
            endIf
        endIf
    endIf

    string varName = GetString(actioninfo, "var")

    ; if "get" get it from sub-object or Form!

    if JMap.hasKey(actionInfo, "value")
        int valueType = JMap.valueType(actionInfo, "value")
        if valueType == 2 ; Int
            int value = JMap.getInt(actionInfo, "value")
            SkyScript.SetVariableInt(script, varName, value)
            return ReturnInt(value)
        elseIf valueType == 3 ; Float
            float value = JMap.getFlt(actionInfo, "value")
            SkyScript.SetVariableFloat(script, varName, value)
            return ReturnFloat(value)
        elseIf valueType == 4 ; Form
            Form value = JMap.getForm(actionInfo, "value")
            SkyScript.SetVariableForm(script, varName, value)
            return ReturnForm(value)
        elseIf valueType == 5 ; Object
            int value = JMap.getObj(actionInfo, "value")
            SkyScript.SetVariableObject(script, varName, value)
            return ReturnObject(value)
        elseIf valueType == 6 ; String
            string value = JMap.getStr(actionInfo, "value")
            SkyScript.SetVariableString(script, varName, value)
            return ReturnString(value)
        endIf
    endIf

    return 0
endFunction