scriptName _SkyScript_Runner hidden

function RunAction(int actionInfo) global
    _SkyScript_ActionHandlers handlers = _SkyScript_ActionHandlers.GetInstance()

    bool handled = false
    int handlerIndex = 0
    while (! handled) && handlerIndex < handlers.HandlerCount
        SkyScriptActionHandler handler = handlers.GetHandler(handlerIndex)
        if handler
            if handler.Match(actionInfo)
                handled = true
                handler.Execute(actionInfo)
            endIf
        endIf
        handlerIndex += 1
    endWhile

    if ! handled
        Debug.MessageBox("Action unsupported: " + _SkyScript_Log.ToJson(actionInfo))
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
