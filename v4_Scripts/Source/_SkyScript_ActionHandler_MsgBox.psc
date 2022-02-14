scriptName _SkyScript_ActionHandler_MsgBox extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("msgbox")       
endEvent

int function Execute(int script, int actionInfo)
    string text = SkyScript.InterpolateString(script, GetString(actionInfo, "msgbox"))
    Debug.MessageBox(text)
    return ReturnString(text)
endFunction
