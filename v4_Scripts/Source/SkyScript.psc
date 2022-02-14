scriptName SkyScript hidden

string function GetVersion() global
    return "0.1.0"
endFunction

string function DirectoryPath() global
    return "Data/SkyScript"
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Initialization + Dispose
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int function Initialize(string filepath = "") global
    if filepath
        return _SkyScript_ScriptInstance.InitializeFromFile(filepath)
    else
        return _SkyScript_ScriptInstance.Initialize()
    endIf
endFunction

function Dispose(int script) global
    _SkyScript_ScriptInstance.Dispose(script)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Running, Pausing, Resuming, Killing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Todo figure out how to return the response... there needs to be some option where you'll return it but an option to clean it up...
int function Run(int script) global
    _SkyScript_Runner.Resumescript(script)
    return script
endFunction

int function RunFile(string filepath) global
    int script = Initialize(filepath)
    if script
        Run(script)
        Dispose(script)
    endIf
endFunction

int function RunText(string expression) global
    int script = _SkyScript_ScriptInstance.InitializeFromString(expression)
    if script
        Run(script)
        Dispose(script)
    endIf
endFunction

function Pause(int script) global
    _SkyScript_ScriptInstance.Pause(script)
endFunction

bool function IsPaused(int script) global
    return _SkyScript_ScriptInstance.IsPaused(script)
endFunction

function Resume(int script) global
    _SkyScript_ScriptInstance.Resume(script)
endFunction

function Kill(int script) global
    _SkyScript_ScriptInstance.Kill(script)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Parent Script
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int function GetScriptParent(int script) global
    return JMap.getObj(script, "parent")
endFunction

function SetScriptParent(int script, int parentInstance) global
    JMap.setObj(script, "parent", parentInstance)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Actions of script
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function SetScriptActions(int script, int actionArray) global
    if JValue.isArray(actionArray)
        JMap.setObj(script, "actions", actionArray)
    elseIf actionArray
        int actionsArray = JArray.object()
        JArray.addObj(actionsArray, actionArray)
        JMap.setObj(script, "actions", actionsArray)
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int function DeclareVariable(int script, string name) global
    int varMap = _SkyScript_ScriptInstance.GetVariableMap(script)
    if JMap.hasKey(varMap, name)
        return JMap.getObj(varMap, name)
    else
        int variable = JMap.object()
        JMap.setObj(varMap, name, variable)
        return variable
    endIf
endFunction

bool function HasVariable(int script, string name) global
    int varMap = _SkyScript_ScriptInstance.GetVariableMap(script)
    if JMap.hasKey(varMap, name)
        return true
    endIf
    int parent = GetScriptParent(script)
    if parent
        return HasVariable(parent, name)
    else
        return false
    endIf
endFunction

string function GetVariableType(int script, string name) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getStr(variable, "type")
    else
        return ""
    endIf
endFunction

bool function GetVariableBool(int script, string name, bool default = false) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getInt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableBool(int script, string name, bool value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "bool")
    JMap.removeKey(variable, "value")
    JMap.setInt(variable, "value", value as int)
endFunction

int function GetVariableInt(int script, string name, int default = 0) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getInt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableInt(int script, string name, int value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "int")
    JMap.removeKey(variable, "value")
    JMap.setInt(variable, "value", value)
endFunction

float function GetVariableFloat(int script, string name, float default = 0.0) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getFlt(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableFloat(int script, string name, float value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "float")
    JMap.removeKey(variable, "value")
    JMap.setFlt(variable, "value", value)
endFunction

string function GetVariableString(int script, string name, string default = "") global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getStr(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableString(int script, string name, string value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "string")
    JMap.removeKey(variable, "value")
    JMap.setStr(variable, "value", value)
endFunction

Form function GetVariableForm(int script, string name, Form default = None) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getForm(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableForm(int script, string name, Form value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "Form")
    JMap.removeKey(variable, "value")
    JMap.setForm(variable, "value", value)
endFunction

int function GetVariableObject(int script, string name, int default = 0) global
    int variable = _SkyScript_ScriptInstance.GetVariable(script, name)
    if variable
        return JMap.getObj(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableObject(int script, string name, int value) global
    int variable = DeclareVariable(script, name)
    JMap.setStr(variable, "type", "object")
    JMap.removeKey(variable, "value")
    JMap.setObj(variable, "value", value)
endFunction

int function GetVariable(int script, string varName) global
    return _SkyScript_ScriptInstance.GetVariable(script, varName)
endFunction

string function GetVariableText(int script, string name) global
    string variableType = GetVariableType(script, name)
    if variableType
        if variableType == "object"
            return ToJson(GetVariableObject(script, name))
        elseIf variableType == "string"
            return GetVariableString(script, name)
        elseIf variableType == "int"
            return GetVariableInt(script, name)
        elseIf variableType == "float"
            return GetVariableFloat(script, name)
        elseIf variableType == "form"
            return GetVariableForm(script, name)
        else
            return "UNSUPPORTED VAR TYPE: " + variableType
        endIf
    else
        return ""
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ToJson helper function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO find a new home for this function
string function ToJson(int object) global
    if object
        string tempFile = _SkyScript_Files.GetTempFile()
        JValue.writeToFile(object, tempFile)
        string json = MiscUtil.ReadFromFile(tempFile)
        Utility.WaitMenuMode(0.01)
        _SkyScript_Files.DeleteFile(tempFile)
        return json
    else
        return "[No object]"
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; String interpolation of variables in script context
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string function InterpolateString(int script, string text) global
    if (! text) || (! script)
        return ""
    endIf

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

        string variableText = GetVariableText(script, varName)

        text = beforeVar + variableText + afterVar
        
        varStart = StringUtil.Find(text, "${")
    endWhile
    return text
endFunction
