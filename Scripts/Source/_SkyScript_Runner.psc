scriptName _SkyScript_Runner hidden

; TODO allow for DSLs
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

function RunActionArray(int actionList) global
    if actionList
        int actionCount = JArray.count(actionList)
        int i = 0
        while i < actionCount
            RunAction(JArray.getObj(actionList, i))
            i += 1
        endWhile
    endIf
endFunction

function RunDirectoryScripts(int scripts) global
    if scripts
        string[] fileNames = JMap.allKeysPArray(scripts)
        int i = 0
        while i < fileNames.Length
            string fileName = fileNames[i]
            RunActionArray(JMap.getObj(scripts, fileName))
            i += 1
        endWhile
    endIf
endFunction
