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
        if theForm
            return ReturnForm(theForm)
        else
            return ReturnNone()
        endIF
    elseIf HasField(actionInfo, GETFORMFROMFILE_KEY)
        int formHexAndFileName = GetObject(actionInfo, GETFORMFROMFILE_KEY)
        if JValue.isArray(formHexAndFileName) && JArray.count(formHexAndFileName) == 2
            string formHex = JArray.getStr(formHexAndFileName, 0)
            string fileName = JArray.getStr(formHexAndFileName, 1)
            int formId = FormHelper.HexToInt(formHex)
            Form theForm = Game.GetFormFromFile(formId, fileName)
            if theForm
                return ReturnForm(theForm)
            else
                return ReturnNone()
            endIf
        endIf
    endIf
endFunction
