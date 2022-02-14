scriptName _SkyScript_ActionHandler_Notify extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("notify")
endEvent

int function Execute(int script, int actionInfo)
    string text = SkyScript.InterpolateString(script, GetString(actionInfo, "notify"))
    Debug.Notification(text)
    return ReturnString(text)
endFunction
