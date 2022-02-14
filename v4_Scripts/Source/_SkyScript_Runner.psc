scriptName _SkyScript_Runner hidden

int function Resumescript(int script) global
    _SkyScript_ScriptInstance.MarkAsRunning(script)
    int currentActionIndex = _SkyScript_ScriptInstance.GetCurrentActionIndex(script)
    RunActionArray(script, currentActionIndex)
    _SkyScript_ScriptInstance.MarkAsNotRunning(script)
    if _SkyScript_ScriptInstance.IsMarkedToBeKilled(script)
        _SkyScript_ScriptInstance.Dispose(script)
    endIf
    return SkyScript.GetVariableObject(script, "LAST_RESPONSE")
endFunction

SkyScriptActionHandler function GetHandlerForAction(int script, int actionInfo) global
    string[] actionSyntaxKeys = JMap.allKeysPArray(actionInfo)

    ; Is it variable shorthand?
    if actionSyntaxKeys.Length == 1
        string keyName = actionSyntaxKeys[0]
        if SkyScriptUtil.String_EndsWith(keyName, " =") || SkyScriptUtil.String_EndsWith(keyName, " = ")
            ; The value of this key is a literal variable value
            ; return GetHandlerByName("_SkyScript_ActionHandler_Var")
            return SkyScriptActionHandler.GetHandlerForSyntaxKey("var")
        elseIf SkyScriptUtil.String_EndsWith(keyName, " =>") || SkyScriptUtil.String_EndsWith(keyName, " => ")
            ; The value of this key is an expression to be evaluated
            ; return GetHandlerByName("_SkyScript_ActionHandler_Var")
            return SkyScriptActionHandler.GetHandlerForSyntaxKey("var")
        endIf
    endIf

    ; Try using registered syntax keys
    int i = 0
    while i < actionSyntaxKeys.Length
        SkyScriptActionHandler handler = SkyScriptActionHandler.GetHandlerForSyntaxKey(actionSyntaxKeys[i])
        if handler
            return handler
        endIf
        i += 1
    endWhile

    ; Fallback to MatchSyntax
    _SkyScript_ActionHandlers handlers = _SkyScript_ActionHandlers.GetInstance()
    int handlerIndex = 0
    while handlerIndex < handlers.HandlerCount
        SkyScriptActionHandler handler = handlers.GetHandler(handlerIndex)
        if handler && handler.MatchSyntax(script, actionInfo)
            return handler
        endIf
        handlerIndex += 1
    endWhile

    ; Nope, didn't find it!
    return None
endFunction

; SkyScriptActionHandler function GetHandlerByName(string name) global
; endFunction

; BIG TODO !!!!!!!!!!!!!! Add the response values to a JDB structure so they aren't lost !!!!!!!!!!!!!!

; TODO - Should only wait ONCE per missing syntax PER game load (so we don't wait again and again and again...)
int function RunAction(int script, int actionInfo) global
    ; Check if there is a script associated with this option that is in progress. If so, resume it.
    int runningscript = _SkyScript_ScriptInstance.GetSubscriptForAction(script, actionInfo)
    if runningscript
        return _SkyScript_ScriptInstance.Resume(runningscript)
    endIf

    float waitInterval = SkyScriptConfig.ActionLookup_WaitInterval()
    int waitAttempts = SkyScriptConfig.ActionLookup_WaitAttempts()
    int attempt = 0
    SkyScriptActionHandler handler

    while (! handler) && (attempt < waitAttempts)
        handler = GetHandlerForAction(script, actionInfo)
        Utility.WaitMenuMode(waitInterval)
        attempt += 1
    endWhile

    if handler
        int response = handler.Execute(script, actionInfo)
        SkyScript.SetVariableObject(script, "LAST_RESPONSE", response)
        return response
    else
        Debug.MessageBox("Unsupported SkyScript action: " + _SkyScript_Log.ToJson(actionInfo)) ; TODO Move this to logs! unless some like error config or something
    endIf
endFunction

function RunActionArray(int script, int startIndex = 0) global
    int actionArray = _SkyScript_ScriptInstance.GetActionArray(script)
    if actionArray
        int actionCount = JArray.count(actionArray)
        int i = 0
        ; TODO check for PARENT paused/mark for kill here
        int parent = SkyScript.GetScriptParent(script)
        bool parentPausedOrBeingKilled = parent && (SkyScript.IsPaused(parent) || _SkyScript_ScriptInstance.IsMarkedToBeKilled(script))
        while i < actionCount && (! SkyScript.IsPaused(script)) && (! _SkyScript_ScriptInstance.IsMarkedToBeKilled(script)) && (! parentPausedOrBeingKilled)
            if i >= startIndex
                _SkyScript_ScriptInstance.SetCurrentActionIndex(script, i)
                RunAction(script, JArray.getObj(actionArray, i))
            endIf
            i += 1
        endWhile
    endIf
endFunction

function RunDirectoryScripts(int scripts, string directoryPath) global
    if scripts
        string[] filePaths = JMap.allKeysPArray(scripts)
        int i = 0
        while i < filePaths.Length
            string filePath = filePaths[i]
            SkyScript.RunFile(directoryPath + "/" + filePath)
            i += 1
        endWhile
    endIf
endFunction
