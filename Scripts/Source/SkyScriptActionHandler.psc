scriptName SkyScriptActionHandler extends Quest

int property HandlerId auto
 
event OnInit()
    HandlerId = _SkyScript_ActionHandlers.GetInstance().AddHandler(self)
    RegisterActions()
endEvent

event RegisterActions()
    ; Intended to be overriden
endEvent

int function Execute(string actionName, int actionInfo)
    ; Intended to be overidden
    return 0
endFunction

function RegisterAction(string actionName)
    _SkyScript_ActionNames.Register(actionName, HandlerId)
endFunction

string function GetString(int actionInfo, string field)
    return JMap.getStr(actionInfo, field)
endFunction
