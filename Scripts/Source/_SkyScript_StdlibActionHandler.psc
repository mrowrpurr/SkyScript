scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

event RegisterActions()
    RegisterAction("msgbox")
    RegisterAction("blackscreen")
    RegisterAction("fadetoblack")
    RegisterAction("fadefromblack")
    RegisterAction("wait")
    RegisterAction("closeracemenu")
    RegisterAction("prompt")
endEvent

int function Execute(string actionName, int actionInfo)
    if actionName
        ; Standard actions which use the "action": "something" syntax
        if actionName == "msgbox"
            MessageBox(actionInfo)
        elseIf actionName == "blackscreen"
            BlackScreen(actionInfo)
        elseIf actionName == "fadetoblack"
            FadeToBlack(actionInfo)
        elseIf actionName == "fadefromblack"
            FadeFromBlack(actionInfo)
        elseIf actionName == "wait"
            Wait(actionInfo)
        elseIf actionName == "prompt"
            Prompt(actionInfo)
        elseIf actionName == "closeracemenu"
            CloseRaceMenu(actionInfo)
        endIf
    ; Customized syntax like "msgbox": "hello" (without using "action": "something")
    ; Note: don't forget to update MatchAction() when adding to this
    elseIf JMap.hasKey(actionInfo, "msgbox")
        MessageBox(actionInfo)
    elseIf JMap.hasKey(actionInfo, "wait")
        Wait(actionInfo)
    elseIf JMap.hasKey(actionInfo, "prompt")
        Prompt(actionInfo)
    endIf
endFunction

bool function MatchAction(int actionInfo)
    if JMap.hasKey(actionInfo, "msgbox")
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

function Prompt(int actionInfo)
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
    int option = JMap.getObj(optionMap, resultText)
    if option
        _SkyScript_Runner.RunAction(option)
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
