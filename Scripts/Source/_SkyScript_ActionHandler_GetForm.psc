scriptName _SkyScript_ActionHandler_GetForm extends SkyScriptActionHandler

string property GETFORM_KEY = "getform" autoReadonly
string property GETFORMFROMFILE_KEY = "getformfromfile" autoReadonly

event RegisterSyntax()
    AddSyntax(GETFORM_KEY)
    AddSyntax(GETFORMFROMFILE_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    if HasField(actionInfo, GETFORM_KEY)
        string formHex = GetString(actionInfo, GETFORM_KEY)
        Form theForm = FormHelper.HexToForm(formHex)
        return ReturnForm(theForm)
    elseIf HasField(actionInfo, "getformfromfile")
        Debug.MessageBox("TODO - GetFormFromFile")
    endIf
endFunction
