scriptName _SkyScript_Files hidden

string function StartupScriptsPath() global
    return SkyScript.DirectoryPath() + "/Events/Startup"
endFunction

int function LoadStartupScripts() global
    return _SkyScript_Data.StoreDirectory("startupScript", StartupScriptsPath())
endFunction

string function MenuScriptsPath(string menuName) global
    return SkyScript.DirectoryPath() + "/Events/Menus/" + menuName
endFunction

string function EventScriptsDirectory(string eventName) global
    return SkyScript.DirectoryPath() + "/Events/" + eventName
endFunction

string[] function ScriptFilesForEvent(string eventName) global
    return JContainers.contentsOfDirectoryAtPath(EventScriptsDirectory(eventName), ".json")
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

bool function Exists(string filepath) global
    return JContainers.fileExistsAtPath(filepath) ; Trying this, I usually use MiscUtil
endFunction
