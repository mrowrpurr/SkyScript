scriptName SkyScriptConfig hidden

float function ActionLookup_WaitInterval() global
    return JMap.getFlt(JMap.getObj(_SkyScript_ConfigFile.GetConfigMap(), "actionLookup"), "waitInterval", 0.05)
endFunction

int function ActionLookup_WaitAttempts() global
    return JMap.getInt(JMap.getObj(_SkyScript_ConfigFile.GetConfigMap(), "actionLookup"), "waitAttempts", 200)
endFunction
