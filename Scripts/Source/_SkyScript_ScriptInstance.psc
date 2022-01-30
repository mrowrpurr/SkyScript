scriptName _SkyScript_ScriptInstance hidden

int function InitializeFromFile(string filepath) global
    if MiscUtil.FileExists(filepath)
        int actionsFromFile = JValue.readFromFile(filepath)
        if actionsFromFile
            if JValue.isArray(actionsFromFile)
                int scriptInstance = Initialize()
                SetActionArray(scriptInstance, actionsFromFile)
                SetFilepath(scriptInstance, filepath)
                return scriptInstance
            elseIf JValue.isMap(actionsFromFile) || JValue.isIntegerMap(actionsFromFile) || JValue.isFormMap(actionsFromFile)
                int scriptInstance = Initialize()
                int actionArray = JArray.object()
                JArray.addObj(actionArray, actionsFromFile)
                SetActionArray(scriptInstance, actionArray)
                SetFilepath(scriptInstance, filepath)
                return scriptInstance
            endIf
        endIf
    endIf
    return 0
endFunction

int function Initialize() global
    int scriptInstance = JMap.object()
    JMap.setObj(_RunningScriptInstances(), scriptInstance, scriptInstance)
    JMap.setObj(scriptInstance, "variables", JMap.object())
    return scriptInstance
endFunction

function Dispose(int scriptInstance) global
    JMap.removeKey(_RunningScriptInstances(), scriptInstance)
endFunction

int function Get(int scriptInstance) global
    return JMap.getObj(_RunningScriptInstances(), scriptInstance)
endFunction

string function GetFilepath(int scriptInstance) global
    return JMap.getStr(scriptInstance, "filepath")
endFunction

function SetFilepath(int scriptInstance, string filepath) global
    JMap.setStr(scriptInstance, "filepath", filepath)
    JMap.setStr(GetVariableMap(scriptInstance), "SCRIPT_FILE", filepath)
endFunction

int function GetActionArray(int scriptInstance) global
    return JMap.getObj(scriptInstance, "actions")
endFunction

function SetActionArray(int scriptInstance, int actionArray) global
    JMap.setObj(scriptInstance, "actions", actionArray)
endFunction

int function GetVariableMap(int scriptInstance) global
    return JMap.getObj(scriptInstance, "variables")
endFunction

int function _RunningScriptInstances() global
    return _SkyScript_Data.FindOrCreateMap(".scripts")
endFunction
