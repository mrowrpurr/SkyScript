scriptName _SkyScript_ActionHandler_On extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("on")
endEvent

int function Execute(int script, int actionInfo)
    Debug.MessageBox("Disabled ON support for events until we do active handler counting")
    ; string eventName = GetString(actionInfo, "on")
    ; int eventScript = GetObject(actionInfo, "run")
    ; _SkyScript_Events.AddEventHandler(eventName, eventScript)
    ; return ReturnString(eventName)
endFunction
