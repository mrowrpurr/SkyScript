scriptName _SkyScript_Files hidden

string function StartupScriptsPath() global
    return SkyScript.DirectoryPath() + "/Startup"
endFunction

int function LoadStartupScripts() global
    return _SkyScript_Data.StoreDirectory("startupScript", StartupScriptsPath())
endFunction
