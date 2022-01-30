scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

event RegisterActions()
    RegisterAction("msgbox")
    RegisterAction("blackscreen")
    RegisterAction("fadetoblack")
    RegisterAction("fadefromblack")
    RegisterAction("wait")
endEvent

int function Execute(string actionName, int actionInfo)
    if actionName
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
        endIf
    elseIf JMap.hasKey(actionInfo, "msgbox")
        MessageBox(actionInfo)
    elseIf JMap.hasKey(actionInfo, "wait")
        Wait(actionInfo)
    endIf
endFunction

bool function MatchAction(int actionInfo)
    if JMap.hasKey(actionInfo, "msgbox")
        return true
    elseIf JMap.hasKey(actionInfo, "wait")
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
