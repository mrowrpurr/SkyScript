scriptName _SkyScript_ActionHandler_If extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("if")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    int condition = JMap.getObj(actionInfo, "if")
    bool result = ResponseBool(RunCondition(scriptInstance, condition))
    if result
        if JMap.hasKey(actionInfo, "then")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
            _SkyScript_ScriptInstance.SetActionArray(subscript, JMap.getObj(actionInfo, "then"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(true)
    else
        if JMap.hasKey(actionInfo, "else")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
            _SkyScript_ScriptInstance.SetActionArray(subscript, JMap.getObj(actionInfo, "else"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(false)
    endIf
endFunction

int function RunCondition(int scriptInstance, int condition)
    int subscript = _SkyScript_ScriptInstance.Initialize()
    _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
    _SkyScript_ScriptInstance.SetActionArray(subscript, condition)
    return _SkyScript_ScriptInstance.Run(subscript)
endFunction
