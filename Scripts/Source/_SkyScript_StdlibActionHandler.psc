scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

event RegisterActions()
    RegisterAction("msgbox")
endEvent

int function Execute(string actionName, int actionInfo)
    if actionName == "msgbox"
        Debug.MessageBox(GetString(actionInfo, "text"))
    endIf
endFunction
