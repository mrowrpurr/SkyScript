scriptName _SkyScript_ActionNames hidden

function Register(string actionName, int handlerId) global
    JMap.setInt(_ActionNameMap(), actionName, handlerId)
endFunction

SkyScriptActionHandler function HandlerForAction(string actionName) global
    int handlerId = JMap.getInt(_ActionNameMap(), actionName, -1)
    if handlerId != -1
        return _SkyScript_ActionHandlers.GetInstance().GetHandler(handlerId)
    else
        return None
    endIf
endFunction

int function _ActionNameMap() global
    return _SkyScript_Data.FindOrCreateMap("actions")
endFunction
