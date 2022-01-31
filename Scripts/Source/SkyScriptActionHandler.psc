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
