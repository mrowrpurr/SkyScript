scriptName _SkyScript_ConfigFile hidden

string function ConfigFilePath() global
    return SkyScript.DirectoryPath() + "/SkyScript.json"
endFunction

function ReloadFromFile() global
    int config
    string configFilePath = ConfigFilePath()
    if _SkyScript_Files.Exists(configFilePath)
        config = JValue.readFromFile(configFilePath)
    endIf
    _SkyScript_Data.Store("config", config)
endFunction

int function GetConfigMap() global
    int config = _SkyScript_Data.Get("config")
    if ! config
        _SkyScript_Data.Store("config", JMap.object())
    endIf
    return config
endFunction
