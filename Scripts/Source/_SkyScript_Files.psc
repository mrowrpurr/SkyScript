scriptName _SkyScript_Files hidden

string function StartupScriptsPath() global
    return SkyScript.DirectoryPath() + "/Startup"
endFunction

int function LoadStartupScripts() global
    return _SkyScript_Data.StoreDirectory("startupScript", StartupScriptsPath())
endFunction

string function TempPath() global
    return SkyScript.DirectoryPath() + "/Temp"
endFunction

string function GetTempFile(string extension = "") global
    string filename = Utility.RandomFloat(0, 1000000)
    return TempPath() + "/" + filename + extension
endFunction

function DeleteFile(string filepath) global
    JContainers.removeFileAtPath(filepath)
endFunction
