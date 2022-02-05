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
    JMap.setObj(scriptInstance, "actionSubscripts", JMap.object())
    return scriptInstance
endFunction

function Dispose(int scriptInstance) global
    JMap.removeKey(_RunningScriptInstances(), scriptInstance)
endFunction

function AddAndRunActionSubScript(int scriptInstance, int actionInfo, int subscriptActions) global
    int subscriptInstance = AddActionSubScript(scriptInstance, actionInfo, subscriptActions)
    _SkyScript_Runner.ResumeScriptInstance(subscriptInstance)
    if ! SkyScript.IsPaused(subscriptInstance)
        Dispose(subscriptInstance)
    endIf
endFunction

int function AddActionSubScript(int scriptInstance, int actionInfo, int subscriptActions) global
    int map = GetActionToSubScriptMap(scriptInstance)
    int subscriptInstance = _SkyScript_ScriptInstance.Initialize()
    JMap.setObj(map, actionInfo, subscriptInstance)
    SetParent(subscriptInstance, scriptInstance)
    _SkyScript_ScriptInstance.SetActionArray(subscriptInstance, subscriptActions)
    return subscriptInstance
endFunction

function MarkAsRunning(int scriptInstance) global
    JMap.setInt(scriptInstance, "running", 1)
endFunction

function MarkAsNotRunning(int scriptInstance) global
    JMap.setInt(scriptInstance, "running", 0)
endFunction

bool function IsRunning(int scriptInstance) global
    return JMap.getInt(scriptInstance, "running")
endFunction

function Pause(int scriptInstance) global
    JMap.setInt(scriptInstance, "paused", 1)
endFunction

bool function IsPaused(int scriptInstance) global
    int parent = GetParent(scriptInstance)
    return JMap.getInt(scriptInstance, "paused") || (parent && IsPaused(parent))
endFunction

function Resume(int scriptInstance) global
    JMap.setInt(scriptInstance, "paused", 0)
    _SkyScript_Runner.ResumeScriptInstance(scriptInstance)
endFunction

function Kill(int scriptInstance) global
    if IsRunning(scriptInstance) && (! IsPaused(scriptInstance))
        JMap.setInt(scriptInstance, "killed", 1)
    else
        Dispose(scriptInstance)
    endIf
endFunction

bool function IsMarkedToBeKilled(int scriptInstance) global
    return JMap.getInt(scriptInstance, "killed")
endFunction

int function Get(int scriptInstance) global
    return JMap.getObj(_RunningScriptInstances(), scriptInstance)
endFunction

string function GetFilepath(int scriptInstance) global
    return JMap.getStr(scriptInstance, "filepath")
endFunction

function SetFilepath(int scriptInstance, string filepath) global
    JMap.setStr(scriptInstance, "filepath", filepath)
    ; JMap.setStr(GetVariableMap(scriptInstance), "SCRIPT_FILE", filepath)
endFunction

int function GetActionArray(int scriptInstance) global
    return JMap.getObj(scriptInstance, "actions")
endFunction

function SetCurrentActionIndex(int scriptInstance, int actionIndex) global
    JMap.setInt(scriptInstance, "currentActionIndex", actionIndex)
endFunction

int function GetCurrentActionIndex(int scriptInstance) global
    return JMap.getInt(scriptInstance, "currentActionIndex")
endFunction

function SetActionArray(int scriptInstance, int actionArray) global
    if JValue.isArray(actionArray)
        JMap.setObj(scriptInstance, "actions", actionArray)
    elseIf actionArray
        int actionsArray = JArray.object()
        JArray.addObj(actionsArray, actionArray)
        JMap.setObj(scriptInstance, "actions", actionsArray)
    endIf
endFunction

function SetParent(int scriptInstance, int parentInstance) global
    JMap.setObj(scriptInstance, "parent", parentInstance)
endFunction

int function GetParent(int scriptInstance) global
    return JMap.getObj(scriptInstance, "parent")
endFunction

int function GetVariableMap(int scriptInstance) global
    return JMap.getObj(scriptInstance, "variables")
endFunction

int function GetSubScriptInstanceForAction(int scriptInstance, int actionInfo) global
    return JMap.getObj(GetActionToSubScriptMap(scriptInstance), actionInfo)
endFunction

int function GetActionToSubScriptMap(int scriptInstance) global
    return JMap.getObj(scriptInstance, "actionSubscripts")
endFunction

int function _RunningScriptInstances() global
    return _SkyScript_Data.FindOrCreateMap("scripts")
endFunction

int function DeclareVariable(int scriptInstance, string name) global
    int varMap = GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return JMap.getObj(varMap, name)
    else
        int variable = JMap.object()
        JMap.setObj(varMap, name, variable)
        return variable
    endIf
endFunction

bool function VarExists(int scriptInstance, string name) global
    int varMap = GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return true
    endIf
    int parent = GetParent(scriptInstance)
    if parent
        return VarExists(parent, name)
    else
        return false
    endIf
endFunction

int function GetVariable(int scriptInstance, string name) global
    int varMap = GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return JMap.getObj(varMap, name)
    endIf
    int parent = GetParent(scriptInstance)
    if parent
        return GetVariable(parent, name)
    else
        return 0
    endIf
endFunction

int function GetVariableInt(int scriptInstance, string name, int default = 0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getInt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableInt(int scriptInstance, string name, int value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "int")
    JMap.removeKey(variable, "value")
    JMap.setInt(variable, "value", value)
endFunction

float function GetVariableFloat(int scriptInstance, string name, float default = 0.0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getFlt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableFloat(int scriptInstance, string name, float value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "float")
    JMap.removeKey(variable, "value")
    JMap.setFlt(variable, "value", value)
endFunction

string function GetVariableString(int scriptInstance, string name, string default = "") global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getStr(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableString(int scriptInstance, string name, string value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "string")
    JMap.removeKey(variable, "value")
    JMap.setStr(variable, "value", value)
endFunction

Form function GetVariableForm(int scriptInstance, string name, Form default = None) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getForm(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableForm(int scriptInstance, string name, Form value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "Form")
    JMap.removeKey(variable, "value")
    JMap.setForm(variable, "value", value)
endFunction

int function GetVariableObject(int scriptInstance, string name, int default = 0) global
    int variable = GetVariable(scriptInstance, name)
    if variable
        return JMap.getInt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableObject(int scriptInstance, string name, int value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "object")
    JMap.removeKey(variable, "value")
    JMap.setInt(variable, "value", value)
endFunction

string function GetVariableText(int scriptInstance, string name) global
    ; TODO
    return GetVariableString(scriptInstance, name) ; Just strings to test with
endFunction

string function InterpolateString(int scriptInstance, string text) global
    int varStart = StringUtil.Find(text, "${")
    while varStart > -1
        int varEnd = StringUtil.Find(text, "}", varStart)
        string varName = StringUtil.Substring(text, varStart + 2, (varEnd - varStart - 2))
        
        string beforeVar = ""
        if varStart > 0
            beforeVar = StringUtil.Substring(text, 0, varStart)
        endIf

        string afterVar = ""
        if varEnd != StringUtil.GetLength(text) - 1
            afterVar = StringUtil.Substring(text, varEnd + 1)
        endIf

        string variableText = GetVariableText(scriptInstance, varName)

        text = beforeVar + variableText + afterVar
        
        varStart = StringUtil.Find(text, "${")
    endWhile
    return text
endFunction
