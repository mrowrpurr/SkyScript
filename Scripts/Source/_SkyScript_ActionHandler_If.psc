scriptName _SkyScript_ActionHandler_If extends SkyScriptActionHandler

string property ACTION_KEY = "if" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int script, int actionInfo)
    if IsString(actionInfo, ACTION_KEY)
        string value = GetString(actionInfo, ACTION_KEY)
        if SkyScript.HasVariable(script, value)
            string variableType = SkyScript.GetVariableType(script, value)
            if variableType == "bool"
                return ReturnBool(SkyScript.GetVariableBool(script, value))
            elseIf variableType == "int"
                return ReturnBool(SkyScript.GetVariableInt(script, value))
            elseIf variableType == "float"
                return ReturnBool(SkyScript.GetVariableFloat(script, value))
            elseIf variableType == "form"
                return ReturnBool(SkyScript.GetVariableForm(script, value))
            elseIf variableType == "object"
                return ReturnBool(SkyScript.GetVariableObject(script, value))
            elseIf variableType == "string"
                return ReturnBool(SkyScript.GetVariableString(script, value))
            endIf
        else
            string interpolated = InterpolateString(script, value)
            if interpolated && interpolated != "0" && StringUtil.GetLength(interpolated) > 0
                return ReturnBool(true)
            else
                return ReturnBool(false)
            endIf
        endIf
    endIf

    int condition = JMap.getObj(actionInfo, ACTION_KEY)
    bool result = ResponseBool(RunCondition(script, condition))
    if result
        if JMap.hasKey(actionInfo, "then")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            SkyScript.SetScriptParent(subscript, script)
            SkyScript.SetScriptActions(subscript, JMap.getObj(actionInfo, "then"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(true)
    else
        if JMap.hasKey(actionInfo, "else")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            SkyScript.SetScriptParent(subscript, script)
            SkyScript.SetScriptActions(subscript, JMap.getObj(actionInfo, "else"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(false)
    endIf
endFunction

int function RunCondition(int script, int condition)
    int subscript = _SkyScript_ScriptInstance.Initialize()
    SkyScript.SetScriptParent(subscript, script)
    SkyScript.SetScriptActions(subscript, condition)
    return _SkyScript_ScriptInstance.Run(subscript)
endFunction
