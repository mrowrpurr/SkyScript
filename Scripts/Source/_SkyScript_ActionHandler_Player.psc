scriptName _SkyScript_ActionHandler_Player extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("player")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string playerRequest = GetString(actionInfo, "player")
    if playerRequest == "getsex"
        if Player.GetActorBase().GetSex() == 0
            return ReturnString("Male")
        else
            return ReturnString("Female")
        endIf
    elseIf playerRequest == "getrace"
        return ReturnString(Player.GetRace().GetName())
    endIf
endFunction
