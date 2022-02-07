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

int function GetScriptParent(int scriptInstance) global
    return JMap.getObj(scriptInstance, "parent")
endFunction

int function DeclareVariable(int scriptInstance, string name) global
    int varMap = _SkyScript_ScriptInstance.GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return JMap.getObj(varMap, name)
    else
        int variable = JMap.object()
        JMap.setObj(varMap, name, variable)
        return variable
    endIf
endFunction

bool function VarExists(int scriptInstance, string name) global
    int varMap = _SkyScript_ScriptInstance.GetVariableMap(scriptInstance)
    if JMap.hasKey(varMap, name)
        return true
    endIf
    int parent = GetScriptParent(scriptInstance)
    if parent
        return VarExists(parent, name)
    else
        return false
    endIf
endFunction

string function GetVariableType(int scriptInstance, string name) global
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
    if variable
        return JMap.getStr(variable, "type")
    else
        return ""
    endIf
endFunction

int function GetVariableInt(int scriptInstance, string name, int default = 0) global
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
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
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
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
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
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
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
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
    int variable = _SkyScript_ScriptInstance.GetVariable(scriptInstance, name)
    if variable
        return JMap.getObj(variable, "value")
    else
        return default
    endIf
endFunction

function SetVariableObject(int scriptInstance, string name, int value) global
    int variable = DeclareVariable(scriptInstance, name)
    JMap.setStr(variable, "type", "object")
    JMap.removeKey(variable, "value")
    JMap.setObj(variable, "value", value)
endFunction

string function GetVariableText(int scriptInstance, string name) global
    string variableType = GetVariableType(scriptInstance, name)
    if variableType
        if variableType == "object"
            return ToJson(GetVariableObject(scriptInstance, name))
        elseIf variableType == "string"
            return GetVariableString(scriptInstance, name)
        elseIf variableType == "int"
            return GetVariableInt(scriptInstance, name)
        elseIf variableType == "float"
            return GetVariableFloat(scriptInstance, name)
        elseIf variableType == "form"
            return GetVariableForm(scriptInstance, name)
        else
            return "UNSUPPORTED VAR TYPE: " + variableType
        endIf
    else
        return ""
    endIf
endFunction

; TODO find a new home for this function
string function ToJson(int object) global
    if object
        string tempFile = _SkyScript_Files.GetTempFile()
        JValue.writeToFile(object, tempFile)
        string json = MiscUtil.ReadFromFile(tempFile)
        _SkyScript_Files.DeleteFile(tempFile)
        return json
    else
        return "[No object]"
    endIf
endFunction

string function InterpolateString(int scriptInstance, string text) global
    if ! text
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

        string variableText = GetVariableText(scriptInstance, varName)

        text = beforeVar + variableText + afterVar
        
        varStart = StringUtil.Find(text, "${")
    endWhile
    return text
endFunction
