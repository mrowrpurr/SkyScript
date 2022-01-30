scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

event RegisterActions()
    RegisterAction("msgbox")
endEvent

int function Execute(string actionName, int actionInfo)
    if actionName
        if actionName == "msgbox"
            Debug.MessageBox(GetString(actionInfo, "text"))
        endIf
    elseIf JMap.hasKey(actionInfo, "msgbox")
        Debug.MessageBox(GetString(actionInfo, "msgbox"))
    endIf
endFunction

bool function MatchAction(int actionInfo)
    if JMap.hasKey(actionInfo, "msgbox")
        return true
    endIf
    return false
endFunction
