scriptName _SkyScript_ActionHandler_Msg extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("msg")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    _SkyScript_Quest ss = _SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_Quest
    
    ; Set the message Text
    string text = SkyScript.InterpolateString(scriptInstance, JMap.getStr(actionInfo, "msg"))
    ss.SkyrimScripting_MessageText_BaseForm.SetName(text)

    ; Reset all message buttons
    bool anyButtons = false
    if JMap.hasKey(actionInfo, "back")
        ss.SkyrimScripting_Message_Generic_Back.Value = 1
        anyButtons = true
    else
        ss.SkyrimScripting_Message_Generic_Back.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "yes")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Yes.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Yes.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "no")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_No.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_No.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "default")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Default.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Default.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "ok")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Ok.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Ok.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "continue")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Continue.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Continue.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "next")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Next.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Next.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "exit")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Exit.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Exit.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "cancel")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Cancel.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Cancel.Value = 0
    endIf

    int back = 0
    int yes = 1
    int no = 2
    int default = 3
    int ok = 4
    int continue = 6
    int next = 7
    int exit = 8
    int cancel = 9

    int result = ss.SkyrimScripting_Message_Generic.Show()

    if ! anyButtons
        return ReturnString("OK")
    endIf

    string resultText
    int resultAction
    if result == back
        resultAction = JMap.getObj(actionInfo, "back")
        resultText = "back"
    elseIf result == yes
        resultAction = JMap.getObj(actionInfo, "yes")
        resultText = "yes"
    elseIf result == no
        resultAction = JMap.getObj(actionInfo, "no")
        resultText = "no"
    elseIf result == default
        resultAction = JMap.getObj(actionInfo, "default")
        resultText = "default"
    elseIf result == ok
        resultAction = JMap.getObj(actionInfo, "ok")
        resultText = "ok"
    elseIf result == continue
        resultAction = JMap.getObj(actionInfo, "continue")
        resultText = "continue"
    elseIf result == next
        resultAction = JMap.getObj(actionInfo, "next")
        resultText = "next"
    elseIf result == exit
        resultAction = JMap.getObj(actionInfo, "exit")
        resultText = "exit"
    elseIf result == cancel || result == -1
        resultAction = JMap.getObj(actionInfo, "cancel")
        resultText = "cancel"
    endIf

    if resultAction
        _SkyScript_ScriptInstance.AddAndRunActionSubScript(scriptInstance, actionInfo, resultAction)
    endIf

    return ReturnString(resultText)
endFunction
