scriptName _SkyScript_ActionHandler_MsgBox extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("msgbox")       
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string text = SkyScript.InterpolateString(scriptInstance, GetString(actionInfo, "msgbox"))
    Debug.MessageBox(text)
    return ReturnString(text)
endFunction
