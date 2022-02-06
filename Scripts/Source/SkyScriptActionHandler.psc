scriptName SkyScriptActionHandler extends Quest

int property HandlerId auto
 
event OnInit()
    HandlerId = _SkyScript_ActionHandlers.GetInstance().AddHandler(self)
    RegisterSyntax()
endEvent

bool function MatchSyntax(int scriptInstance, int actionInfo)
    ; Intended to be optionally overriden
    return false
endFunction

event RegisterSyntax()
    ; Intended to be overriden
endEvent

int function Execute(int scriptInstance, int actionInfo)
    ; Intended to be overidden
    return 0
endFunction

function AddSyntax(string keyName)
    SkyScriptLock.AcquireLock("AddSkyScriptActionHandlerSyntax")
    JMap.setInt(_KeyNameMap(), keyName, HandlerId)
    SkyScriptLock.ReleaseLock("AddSkyScriptActionHandlerSyntax")
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

int function GetObject(int actionInfo, string field)
    return JMap.getObj(actionInfo, field)
endFunction

Form function GetForm(int actionInfo, string field)
    return JMap.getForm(actionInfo, field)
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

bool function ResponseBool(int response)
    return GetResponseBool(response)
endFunction

string function ResponseString(int response)
    return GetResponseString(response)
endFunction

int function ResponseInt(int response)
    return GetResponseInt(response)
endFunction

float function ResponseFloat(int response)
    return GetResponseFloat(response)
endFunction

Form function ResponseForm(int theForm)
    return GetResponseForm(theForm)
endFunction

int function ResponseObject(int object)
    return GetResponseObject(object)
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

string function GetResponseType(int response) global
    return JMap.getStr(response, "type")
endFunction

bool function GetResponseBool(int response) global
    return JMap.getInt(response, "value") || JMap.getStr(response, "value")
endFunction

int function GetResponseInt(int response) global
    return JMap.getInt(response, "value")
endFunction

float function GetResponseFloat(int response) global
    return JMap.getFlt(response, "value")
endFunction

string function GetResponseString(int response) global
    return JMap.getStr(response, "value")
endFunction

Form function GetResponseForm(int response) global
    return JMap.getForm(response, "value")
endFunction

int function GetResponseObject(int response) global
    return JMap.getObj(response, "value")
endFunction

SkyScriptActionHandler function GetHandlerForSyntaxKey(string actionName) global
    int theHandlerId = JMap.getInt(_KeyNameMap(), actionName, -1)
    if theHandlerId != -1
        return _SkyScript_ActionHandlers.GetInstance().GetHandler(theHandlerId)
    else
        return None
    endIf
endFunction

int function _KeyNameMap() global
    return _SkyScript_Data.FindOrCreateMap("actionHandlerKeys")
endFunction
