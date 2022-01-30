scriptName _SkyScript_Runner hidden

function RunAction(int scriptAction) global
    ; SCRIPT LOOKUP!
    Debug.MessageBox("Will run action! " + _SkyScript_Log.ToJson(scriptAction))
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
