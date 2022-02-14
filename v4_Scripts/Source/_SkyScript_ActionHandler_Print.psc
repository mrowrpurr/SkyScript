scriptName _SkyScript_ActionHandler_Print extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("print")
endEvent

int function Execute(int script, int actionInfo)
    string text = SkyScript.InterpolateString(script, GetString(actionInfo, "print"))
    if PapyrusUtil.GetVersion()
        MiscUtil.PrintConsole(text)
    elseIf ConsoleUtil.GetVersion()
        ConsoleUtil.PrintMessage(text)
    else
        UI.InvokeString("Console", "_global.Console.AddHistory", text)
    endIf
    return ReturnString(text)
endFunction
