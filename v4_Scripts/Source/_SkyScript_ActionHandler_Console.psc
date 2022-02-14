scriptName _SkyScript_ActionHandler_Console extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("console")
endEvent

int function Execute(int script, int actionInfo)
    string command = InterpolateString(script, JMap.getStr(actionInfo, "console"))
    if command
        if ConsoleUtil.GetVersion()
            ConsoleUtil.ExecuteCommand(command)
        elseIf ConsoleCommands.IsCustomConsoleCommandsSupported()
            UI.InvokeString("Console", "_global.Console.ExecuteCommand", command) 
        else
            ; ERROR
        endIf
    endIf
    return ReturnNone() ; TODO - grab the console output of the command via command history
endFunction
