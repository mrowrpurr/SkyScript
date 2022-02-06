scriptName _SkyScript_ActionHandler_Notify extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("notify")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string text = SkyScript.InterpolateString(scriptInstance, GetString(actionInfo, "notify"))
    Debug.Notification(text)
    return ReturnString(text)
endFunction
