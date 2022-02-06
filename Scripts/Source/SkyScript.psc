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

function Dispose(int scriptInstance) global
    _SkyScript_ScriptInstance.Dispose(scriptInstance)
endFunction

int function Run(int scriptInstance) global
    _SkyScript_Runner.ResumeScriptInstance(scriptInstance)
    return scriptInstance
endFunction

int function RunFile(string filepath) global
    int scriptInstance = Initialize(filepath)
    Run(scriptInstance)
    Dispose(scriptInstance)
endFunction

function Pause(int scriptInstance) global
    _SkyScript_ScriptInstance.Pause(scriptInstance)
endFunction

bool function IsPaused(int scriptInstance) global
    return _SkyScript_ScriptInstance.IsPaused(scriptInstance)
endFunction

function Resume(int scriptInstance) global
    _SkyScript_ScriptInstance.Resume(scriptInstance)
endFunction

function Kill(int scriptInstance) global
    _SkyScript_ScriptInstance.Kill(scriptInstance)
endFunction

string function InterpolateString(int scriptInstance, string text) global
    return _SkyScript_ScriptInstance.InterpolateString(scriptInstance, text)
endFunction
