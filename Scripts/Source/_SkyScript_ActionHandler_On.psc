scriptName _SkyScript_ActionHandler_On extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("on")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string eventName = GetString(actionInfo, "on")
    int eventScript = GetObject(actionInfo, "run")
    _SkyScript_Events.AddEventHandler(eventName, eventScript)
    return ReturnString(eventName)
endFunction
