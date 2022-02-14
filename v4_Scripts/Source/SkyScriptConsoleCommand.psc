scriptName SkyScriptConsoleCommand extends ConsoleCommand

event OnCommandInit()
    AddAlias("ss")
endEvent

event OnRun(string[] arguments)
    if ! arguments
        Print("SkyScript version " + SkyScript.GetVersion())
        return
    endIf

    string scriptFile = arguments[0]
    string notFoundText = "SkyScript not found\n-" + scriptFile
    arguments = Shift(arguments)

    bool found = JContainers.fileExistsAtPath(scriptFile)

    if (! found) && StringUtil.Find(scriptFile, ".json") == -1
        scriptFile += ".json"
        notFoundText += "\n- " + scriptFile
        found = JContainers.fileExistsAtPath(scriptFile)
    endIf

    if (! found) && StringUtil.Find(scriptFile, "Data") != 0
        scriptFile = "Data/" + scriptFile
        notFoundText += "\n- " + scriptFile
        found = JContainers.fileExistsAtPath(scriptFile)
    endIf

    if found
        SkyScript.RunFile(scriptFile)
    else
        Print(notFoundText)
        return
    endIf
endEvent
