scriptName _SkyScript_ActionHandler_Wait extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("wait")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    float time = GetFloat(actionInfo, "wait")
    if GetBool(actionInfo, "menu")
        Utility.WaitMenuMode(time)
    else
        Utility.Wait(time)
    endIf
    return ReturnFloat(time)
endFunction
