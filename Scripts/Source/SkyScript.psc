scriptName SkyScript hidden

string function GetVersion() global
    return "0.1.0"
endFunction

string function DirectoryPath() global
    return "Data/SkyScript"
endFunction

int function Initialize(string filepath) global
    return _SkyScript_ScriptInstance.InitializeFromFile(filepath)
endFunction

function Run(int scriptInstance) global
    _SkyScript_Runner.RunActionArray(_SkyScript_ScriptInstance.GetActionArray(scriptInstance))
endFunction

int function RunFile(string filepath) global
    Run(Initialize(filepath))
endFunction

function Pause(int scriptInstance) global

endFunction

function Resume(int scriptInstance) global

endFunction

function Stop(int scriptInstance) global

endFunction
