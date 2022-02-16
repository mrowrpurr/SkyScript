scriptName SkyScriptContext hidden
{Represents a context in which variables and types are loaded.
All scripts run in a context.}

int function Create(int parent = 0) global
    return _SkyScript_Contexts.NewContext(parent)
endFunction

function Dispose(int context) global
    _SkyScript_Contexts.DisposeTopLevelContext(context)
endFunction

function ImportTypes(int context, string typeFilePath) global
    _SkyScript_ClassParser.ParseAndImportTypesFile(context, typeFilePath)
endFunction
