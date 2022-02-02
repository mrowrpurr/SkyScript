scriptName SkyScriptActionHandler extends Quest

int property HandlerId auto
 
event OnInit()
    HandlerId = _SkyScript_ActionHandlers.GetInstance().AddHandler(self)
    RegisterActions()
endEvent

bool function MatchAction(int scriptInstance, int actionInfo)
    ; Intended to be optionally overriden
    return false
endFunction

event RegisterActions()
    ; Intended to be overriden
endEvent

int function Execute(int scriptInstance, string actionName, int actionInfo)
    ; Intended to be overidden
    return 0
endFunction

function RegisterAction(string actionName)
    _SkyScript_ActionNames.Register(actionName, HandlerId)
endFunction

bool function HasField(int actionInfo, string field)
    return JMap.hasKey(actionInfo, field)
endFunction

string function GetString(int actionInfo, string field)
    return JMap.getStr(actionInfo, field)
endFunction

float function GetFloat(int actionInfo, string field)
    return JMap.getFlt(actionInfo, field)
endFunction

int function GetInt(int actionInfo, string field)
    return JMap.getInt(actionInfo, field)
endFunction

bool function GetBool(int actionInfo, string field)
    return JMap.getInt(actionInfo, field) || JMap.getStr(actionInfo, field)
endFunction

int function ReturnBool(bool value)
    return GetReturnBool(value)
endFunction

int function ReturnString(string value)
    return GetReturnString(value)
endFunction

int function ReturnInt(int value)
    return GetReturnInt(value)
endFunction

int function ReturnFloat(float value)
    return GetReturnFloat(value)
endFunction

int function ReturnForm(Form theForm)
    return GetReturnForm(theForm)
endFunction

int function ReturnObject(int object)
    return GetReturnObject(object)
endFunction

int function ReturnNone()
    return GetReturnNone()
endFunction

int function GetReturnBool(bool value) global
    int response = JMap.object()
    JMap.setInt(response, "value", value as int)
    JMap.setStr(response, "type", "bool")
    return response
endFunction

int function GetReturnString(string value) global
    int response = JMap.object()
    JMap.setStr(response, "value", value)
    JMap.setStr(response, "type", "string")
    return response
endFunction

int function GetReturnInt(int value) global
    int response = JMap.object()
    JMap.setInt(response, "value", value)
    JMap.setStr(response, "type", "int")
    return response
endFunction

int function GetReturnFloat(float value) global
    int response = JMap.object()
    JMap.setFlt(response, "value", value)
    JMap.setStr(response, "type", "flopat")
    return response
endFunction

int function GetReturnForm(Form theForm) global
    int response = JMap.object()
    JMap.setForm(response, "value", theForm)
    JMap.setStr(response, "type", "form")
    return response
endFunction

int function GetReturnObject(int object) global
    int response = JMap.object()
    JMap.setInt(response, "value", object)
    JMap.setStr(response, "type", "object")
    return response
endFunction

int function GetReturnNone() global
    int response = JMap.object()
    JMap.setStr(response, "type", "none")
    return response
endFunction
