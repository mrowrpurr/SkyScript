scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

event RegisterActions()
    RegisterAction("msgbox")
    RegisterAction("blackscreen")
    RegisterAction("fadetoblack")
    RegisterAction("fadefromblack")
    RegisterAction("wait")
    RegisterAction("closeracemenu")
    RegisterAction("msg")
    RegisterAction("prompt")
endEvent

int function Execute(int scriptInstance, string actionName, int actionInfo)
    if actionName
        ; Standard actions which use the "action": "something" syntax
        if actionName == "msgbox"
            MessageBox(actionInfo)
        elseIf actionName == "msg"
            Message(scriptInstance, actionInfo)
        elseIf actionName == "blackscreen"
            BlackScreen(actionInfo)
        elseIf actionName == "fadetoblack"
            FadeToBlack(actionInfo)
        elseIf actionName == "fadefromblack"
            FadeFromBlack(actionInfo)
        elseIf actionName == "wait"
            Wait(actionInfo)
        elseIf actionName == "prompt"
            Prompt(scriptInstance, actionInfo)
        elseIf actionName == "closeracemenu"
            CloseRaceMenu(actionInfo)
        endIf
    ; Customized syntax like "msgbox": "hello" (without using "action": "something")
    ; Note: don't forget to update MatchAction() when adding to this
    elseIf JMap.hasKey(actionInfo, "msgbox")
        MessageBox(actionInfo)
    elseIf JMap.hasKey(actionInfo, "msg")
        Message(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "wait")
        Wait(actionInfo)
    elseIf JMap.hasKey(actionInfo, "prompt")
        Prompt(scriptInstance, actionInfo)
    endIf
endFunction

bool function MatchAction(int scriptInstance, int actionInfo)
    if JMap.hasKey(actionInfo, "msgbox")
        return true
    elseIf JMap.hasKey(actionInfo, "msg")
        return true
    elseIf JMap.hasKey(actionInfo, "wait")
        return true
    elseIf JMap.hasKey(actionInfo, "prompt")
        return true
    endIf
    return false
endFunction

function MessageBox(int actionInfo)
    string text = GetString(actionInfo, "text")
    if HasField(actionInfo, "msgbox")
        text = GetString(actionInfo, "msgbox")
    endIf
    Debug.MessageBox(text)
endFunction

function BlackScreen(int actionInfo)
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    fadeToBlackHold.Apply()
endFunction

function FadeToBlack(int actionInfo)
    ImageSpaceModifier fadeToBlack = Game.GetForm(0xf756d) as ImageSpaceModifier
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    float waitBeforeHold = JMap.getFlt(actionInfo, "wait", 2.0)
    fadeToBlack.Apply()
    Utility.Wait(waitBeforeHold)
    fadeToBlack.PopTo(fadeToBlackHold)
endFunction

function FadeFromBlack(int actionInfo)
    ImageSpaceModifier fadeFromBlack = Game.GetForm(0xf756f) as ImageSpaceModifier
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    fadeToBlackHold.PopTo(FadeFromBlack)
    fadeToBlackHold.Remove()
endFunction

function Wait(int actionInfo)
    float time = GetFloat(actionInfo, "duration")
    if HasField(actionInfo, "wait")
        time = GetFloat(actionInfo, "wait")
    endIf
    if GetBool(actionInfo, "menu")
        Utility.WaitMenuMode(time)
    else
        Utility.Wait(time)
    endIf
endFunction

; TODO - update to run actions as subscripts instead of just running an action (so they can be paused)
function Message(int scriptInstance, int actionInfo)    
    ; TODO syntax errors, validation, etc

    _SkyScript_Quest ss = _SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_Quest
    
    ; Set the message Text
    ss.SkyrimScripting_MessageText_BaseForm.SetName(JMap.getStr(actionInfo, "msg"))

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
    int continue = 6
    int next = 7
    int exit = 8
    int cancel = 9

    int result = ss.SkyrimScripting_Message_Generic.Show()

    if ! anyButtons
        return
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
    else
        Debug.MessageBox("NO ACTION REGISTERED FOR RESULT: " + resultText)
    endIf
endFunction

; TODO - update to run actions as subscripts instead of just running an action (so they can be paused)
function Prompt(int scriptInstance, int actionInfo)
    ; TODO Raise a SyntaxError if missing prompt or options

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    int optionMap = JMap.getObj(actionInfo, "options")
    int choicesArray = JMap.getObj(actionInfo, "prompt")
    int choiceCount = JArray.count(choicesArray)
    int i = 0
    while i < choiceCount
        string choiceText = JArray.getStr(choicesArray, i)
        listMenu.AddEntryItem(choiceText)
        i += 1
    endWhile
    listMenu.OpenMenu()
    int resultIndex = listMenu.GetResultInt()
    string resultText
    if resultIndex == -1
        resultText = "Cancel"
    else
        resultText = JArray.getStr(choicesArray, resultIndex)
    endIf
    int resultAction = JMap.getObj(optionMap, resultText)
    if resultAction
        _SkyScript_ScriptInstance.AddAndRunActionSubScript(scriptInstance, actionInfo, resultAction)
    else
        Debug.MessageBox("NO ACTION REGISTERED FOR RESULT: " + resultText)
    endIf
endFunction

function CloseRaceMenu(int actionInfo)
    ; This 100% assumes that you're in RaceMenu
    int enter = 28
    int accept = 19 ; R
    Input.TapKey(accept)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(enter)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(enter)
    Debug.MessageBox("CLOSING RACE MENU ????")
endFunction
