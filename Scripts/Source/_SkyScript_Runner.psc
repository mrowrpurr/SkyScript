scriptName _SkyScript_Runner hidden

function ResumeScriptInstance(int scriptInstance) global
    int currentActionIndex = _SkyScript_ScriptInstance.GetCurrentActionIndex(scriptInstance)
    RunActionArray(scriptInstance, currentActionIndex)
endFunction

function RunAction(int actionInfo) global
    string actionName = JMap.getStr(actionInfo, "action")
    SkyScriptActionHandler handler = _SkyScript_ActionNames.HandlerForAction(actionName)
    if handler
        handler.Execute(actionName, actionInfo)
    else
        ; See if any match
        bool found = false
        _SkyScript_ActionHandlers handlers = _SkyScript_ActionHandlers.GetInstance()
        int handlerIndex = 0
        while (! found) && handlerIndex < handlers.HandlerCount
            handler = handlers.GetHandler(handlerIndex)
            if handler && handler.MatchAction(actionInfo)
                found = true
                handler.Execute(actionName, actionInfo)
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
        while i < actionCount && (! SkyScript.IsPaused(scriptInstance)) && (! _SkyScript_ScriptInstance.IsMarkedToBeKilled(scriptInstance))
            if i >= startIndex
                _SkyScript_ScriptInstance.SetCurrentActionIndex(scriptInstance, i)
                RunAction(JArray.getObj(actionArray, i))
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
