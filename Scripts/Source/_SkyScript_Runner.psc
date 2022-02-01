scriptName _SkyScript_Runner hidden

function ResumeScriptInstance(int scriptInstance) global
    _SkyScript_ScriptInstance.MarkAsRunning(scriptInstance)
    int currentActionIndex = _SkyScript_ScriptInstance.GetCurrentActionIndex(scriptInstance)
    RunActionArray(scriptInstance, currentActionIndex)
    _SkyScript_ScriptInstance.MarkAsNotRunning(scriptInstance)
    if _SkyScript_ScriptInstance.IsMarkedToBeKilled(scriptInstance)
        _SkyScript_ScriptInstance.Dispose(scriptInstance)
    endIf
endFunction

function RunAction(int scriptInstance, int actionInfo) global
    ; Check if there is a script associated with this option that is in progress. If so, resume it.
    int runningScriptInstance = _SkyScript_ScriptInstance.GetSubScriptInstanceForAction(scriptInstance, actionInfo)
    if runningScriptInstance
        _SkyScript_ScriptInstance.Resume(runningScriptInstance)
        return
    endIf

    string actionName = JMap.getStr(actionInfo, "action")
    SkyScriptActionHandler handler = _SkyScript_ActionNames.HandlerForAction(actionName)
    if handler
        handler.Execute(scriptInstance, actionName, actionInfo)
    else
        ; See if any match
        bool found = false
        _SkyScript_ActionHandlers handlers = _SkyScript_ActionHandlers.GetInstance()
        int handlerIndex = 0
        while (! found) && handlerIndex < handlers.HandlerCount
            handler = handlers.GetHandler(handlerIndex)
            if handler && handler.MatchAction(scriptInstance, actionInfo)
                found = true
                handler.Execute(scriptInstance, actionName, actionInfo)
            endIf
            handlerIndex += 1
        endWhile
        if ! found
            Debug.MessageBox("Unsupported SkyScript action: " + _SkyScript_Log.ToJson(actionInfo))
        endIf
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
