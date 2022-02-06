scriptName _SkyScript_Runner hidden

int function ResumeScriptInstance(int scriptInstance) global
    _SkyScript_ScriptInstance.MarkAsRunning(scriptInstance)
    int currentActionIndex = _SkyScript_ScriptInstance.GetCurrentActionIndex(scriptInstance)
    RunActionArray(scriptInstance, currentActionIndex)
    _SkyScript_ScriptInstance.MarkAsNotRunning(scriptInstance)
    if _SkyScript_ScriptInstance.IsMarkedToBeKilled(scriptInstance)
        _SkyScript_ScriptInstance.Dispose(scriptInstance)
    endIf
    return _SkyScript_ScriptInstance.GetVariableObject(scriptInstance, "LAST_RESPONSE")
endFunction

SkyScriptActionHandler function GetHandlerForAction(int scriptInstance, int actionInfo) global
    ; Try using registered syntax keys
    string[] actionSyntaxKeys = JMap.allKeysPArray(actionInfo)
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
        if handler && handler.MatchSyntax(scriptInstance, actionInfo)
            return handler
        endIf
        handlerIndex += 1
    endWhile

    ; Nope, didn't find it!
    return None
endFunction

; TODO - Should only wait ONCE per missing syntax PER game load (so we don't wait again and again and again...)
int function RunAction(int scriptInstance, int actionInfo) global
    ; Check if there is a script associated with this option that is in progress. If so, resume it.
    int runningScriptInstance = _SkyScript_ScriptInstance.GetSubScriptInstanceForAction(scriptInstance, actionInfo)
    if runningScriptInstance
        return _SkyScript_ScriptInstance.Resume(runningScriptInstance)
    endIf

    float waitInterval = SkyScriptConfig.ActionLookup_WaitInterval()
    int waitAttempts = SkyScriptConfig.ActionLookup_WaitAttempts()
    int attempt = 0
    SkyScriptActionHandler handler

    while (! handler) && (attempt < waitAttempts)
        handler = GetHandlerForAction(scriptInstance, actionInfo)
        Utility.WaitMenuMode(waitInterval)
        attempt += 1
    endWhile

    if handler
        int response = handler.Execute(scriptInstance, actionInfo)
        _SkyScript_ScriptInstance.SetVariableObject(scriptInstance, "LAST_RESPONSE", response)
        return response
    else
        Debug.MessageBox("Unsupported SkyScript action: " + _SkyScript_Log.ToJson(actionInfo)) ; TODO Move this to logs! unless some like error config or something
    endIf
endFunction

function RunActionArray(int scriptInstance, int startIndex = 0) global
    int actionArray = _SkyScript_ScriptInstance.GetActionArray(scriptInstance)
    if actionArray
        int actionCount = JArray.count(actionArray)
        int i = 0
        ; TODO check for PARENT paused/mark for kill here
        int parent = _SkyScript_ScriptInstance.GetParent(scriptInstance)
        bool parentPausedOrBeingKilled = parent && (SkyScript.IsPaused(parent) || _SkyScript_ScriptInstance.IsMarkedToBeKilled(scriptInstance))
        while i < actionCount && (! SkyScript.IsPaused(scriptInstance)) && (! _SkyScript_ScriptInstance.IsMarkedToBeKilled(scriptInstance)) && (! parentPausedOrBeingKilled)
            if i >= startIndex
                _SkyScript_ScriptInstance.SetCurrentActionIndex(scriptInstance, i)
                RunAction(scriptInstance, JArray.getObj(actionArray, i))
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
