scriptName _SkyScript_ActionHandler_NotEqual extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("!equal")
    AddSyntax("! equal")
    AddSyntax("notequal")
endEvent

int function Execute(int script, int actionInfo)
    int equalityCheck
    if HasField(actionInfo, "!equal")
        equalityCheck = GetObject(actionInfo, "!equal")
    elseIf HasField(actionInfo, "! equal")
        equalityCheck = GetObject(actionInfo, "! equal")
    elseIf HasField(actionInfo, "notequal")
        equalityCheck = GetObject(actionInfo, "notequal")
    endIf

    string leftHandSideAsString
    int leftHandSideValueType = JArray.valueType(equalityCheck, 0)
    if leftHandSideValueType == 2 ; Int
        leftHandSideAsString = JArray.getInt(equalityCheck, 0)
    elseIf leftHandSideValueType == 3 ; Float
        leftHandSideAsString = JArray.getFlt(equalityCheck, 0)
    elseIf leftHandSideValueType == 4 ; Form
        leftHandSideAsString = JArray.getForm(equalityCheck, 0)
    elseIf leftHandSideValueType == 5 ; Object
        leftHandSideAsString = JArray.getObj(equalityCheck, 0)
    elseIf leftHandSideValueType == 6 ; String
        leftHandSideAsString = JArray.getStr(equalityCheck, 0)
    endIf

    string rightHandSideAsString
    int rightHandSideValueType = JArray.valueType(equalityCheck, 1)
    if rightHandSideValueType == 2 ; Int
        rightHandSideAsString = JArray.getInt(equalityCheck, 1)
    elseIf rightHandSideValueType == 3 ; Float
        rightHandSideAsString = JArray.getFlt(equalityCheck, 1)
    elseIf rightHandSideValueType == 4 ; Form
        rightHandSideAsString = JArray.getForm(equalityCheck, 1)
    elseIf rightHandSideValueType == 5 ; Object
        rightHandSideAsString = JArray.getObj(equalityCheck, 1)
    elseIf rightHandSideValueType == 6 ; String
        rightHandSideAsString = JArray.getStr(equalityCheck, 1)
    endIf

    string leftText = SkyScript.InterpolateString(script, leftHandSideAsString)
    string rightText = SkyScript.InterpolateString(script, rightHandSideAsString)

    return ReturnBool(leftText != rightText)
endFunction
