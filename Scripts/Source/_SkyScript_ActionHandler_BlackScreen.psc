scriptName _SkyScript_ActionHandler_BlackScreen extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("blackscreen")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    ImageSpaceModifier fadeToBlack = Game.GetForm(0xf756d) as ImageSpaceModifier
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    ImageSpaceModifier fadeFromBlack = Game.GetForm(0xf756f) as ImageSpaceModifier
    string actionName = GetString(actionInfo, "blackscreen")
    if actionName == "fadeout"
        float waitBeforeHold = JMap.getFlt(actionInfo, "wait", 2.0)
        fadeToBlack.Apply()
        Utility.Wait(waitBeforeHold)
        fadeToBlack.PopTo(fadeToBlackHold)
    elseIf actionName == "fadein"
        fadeToBlackHold.PopTo(FadeFromBlack)
        fadeToBlackHold.Remove()
    elseIf actionName == "apple"
        fadeToBlackHold.Apply()
    endIf
    return ReturnNone()
endFunction
