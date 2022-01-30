scriptName _SkyScript_Runner hidden

; TODO allow for DSLs
function RunAction(int actionInfo) global
    string actionName = JMap.getStr(actionInfo, "action")
    SkyScriptActionHandler handler = _SkyScript_ActionNames.HandlerForAction(actionName)

    ; Wait up to 1 second for a handler to become available for action (TODO make configurable)
    float currentTime = Utility.GetCurrentRealTime()
    while (! handler) && (Utility.GetCurrentRealTime() - currentTime < 1.0)
        handler = _SkyScript_ActionNames.HandlerForAction(actionName)
        Utility.WaitMenuMode(0.05)
    endWhile

    if handler
        handler.Execute(actionName, actionInfo)
    else
        ; MiscUtil.PrintConsole("Unsupported SkyScript action: " + _SkyScript_Log.ToJson(actionInfo))
        Debug.MessageBox("Unsupported SkyScript action: " + _SkyScript_Log.ToJson(actionInfo))
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
