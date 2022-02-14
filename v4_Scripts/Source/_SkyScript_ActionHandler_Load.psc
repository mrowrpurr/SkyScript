scriptName _SkyScript_ActionHandler_Load extends SkyScriptActionHandler

string property ACTION_KEY = "load" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int script, int actionInfo)
    string scriptPath = GetString(actionInfo, ACTION_KEY)
    scriptPath = SkyScriptUtil.FindFile(scriptPath)
    if scriptPath
        int scriptFileActions = JValue.readFromFile(scriptPath)
        if scriptFileActions
            ; Actions are run in *this context*, not in a subscript.
            if JValue.isArray(scriptFileActions)
                int actionCount = JArray.count(scriptFileActions)
                int i = 0
                while i < actionCount
                    int actionToRun = JArray.getObj(scriptFileActions, i)
                    if actionToRun
                        _SkyScript_Runner.RunAction(script, actionToRun)
                    endIf
                    i += 1
                endWhile
            elseIf JValue.isMap(scriptFileActions)
                _SkyScript_Runner.RunAction(script, scriptFileActions)
            endIf
        endIf
    endIf
endFunction
