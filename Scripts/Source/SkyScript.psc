scriptName SkyScript hidden

string function GetVersion() global
    return "0.1.0"
endFunction

string function DirectoryPath() global
    return "Data/SkyScript"
endFunction

int function Run(string filePath) global
    int scriptInstance = _SkyScript_ScriptInstance.InitializeFromFile(filePath)
    _SkyScript_Runner.RunActionArray(_SkyScript_ScriptInstance.GetActionArray(scriptInstance))
    return scriptInstance
endFunction

function Pause(int scriptInstance) global

endFunction

function Resume(int scriptInstance) global

endFunction
