scriptName SkyScript hidden

string function GetVersion() global
    return "0.1.0"
endFunction

string function DirectoryPath() global
    return "Data/SkyScript"
endFunction

int function Run(string filePath) global
    int scriptInstance = _SkyScript_ScriptInstance.InitializeFromFile(filePath)
    Debug.MessageBox("This will run " + _SkyScript_ScriptInstance.GetFilepath(scriptInstance))
    return scriptInstance
endFunction

function Pause(int scriptInstance) global

endFunction

function Resume(int scriptInstance) global

endFunction
