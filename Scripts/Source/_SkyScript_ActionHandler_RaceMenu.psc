scriptName _SkyScript_ActionHandler_RaceMenu extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("racemenu")
endEvent

int function Execute(int script, int actionInfo)
    string actionName = GetString(actionInfo, "racemenu")
    if actionName == "close"
        ; This 100% assumes that you're in RaceMenu
        int enter = 28
        int accept = 19 ; R
        Input.TapKey(accept)
        Utility.WaitMenuMode(0.1)
        Input.TapKey(enter)
        Utility.WaitMenuMode(0.1)
        Input.TapKey(enter)
    endIf
    return ReturnNone()
endFunction

