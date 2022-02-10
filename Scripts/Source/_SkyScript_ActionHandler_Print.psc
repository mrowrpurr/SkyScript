scriptName _SkyScript_ActionHandler_Print extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("print")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string text = SkyScript.InterpolateString(scriptInstance, GetString(actionInfo, "print"))
    if PapyrusUtil.GetVersion()
        MiscUtil.PrintConsole(text)
    elseIf ConsoleUtil.GetVersion()
        ConsoleUtil.PrintMessage(text)
    else
        UI.InvokeString("Console", "_global.Console.AddHistory", text)
    endIf
    return ReturnString(text)
endFunction
