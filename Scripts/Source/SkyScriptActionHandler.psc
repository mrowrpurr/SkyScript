scriptName SkyScriptActionHandler extends Quest

event OnInit()
    _SkyScript_ActionHandlers.GetInstance().AddHandler(self)
endEvent

bool function Match(int actionInfo)
    ; Intended to be overridden
    return false
endFunction

int function Execute(int actionInfo)
    ; Intended to be overidden
    return 0
endFunction
