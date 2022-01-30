scriptName _SkyScript_ActionHandlers extends Quest  

int property HandlerCount auto

SkyScriptActionHandler[] property Handlers0 auto
SkyScriptActionHandler[] property Handlers1 auto
SkyScriptActionHandler[] property Handlers2 auto
SkyScriptActionHandler[] property Handlers3 auto
SkyScriptActionHandler[] property Handlers4 auto
SkyScriptActionHandler[] property Handlers5 auto
SkyScriptActionHandler[] property Handlers6 auto
SkyScriptActionHandler[] property Handlers7 auto
SkyScriptActionHandler[] property Handlers8 auto
SkyScriptActionHandler[] property Handlers9 auto

event OnInit()
    Handlers0 = new SkyScriptActionHandler[128]
    Handlers1 = new SkyScriptActionHandler[128]
    Handlers2 = new SkyScriptActionHandler[128]
    Handlers3 = new SkyScriptActionHandler[128]
    Handlers4 = new SkyScriptActionHandler[128]
    Handlers5 = new SkyScriptActionHandler[128]
    Handlers6 = new SkyScriptActionHandler[128]
    Handlers7 = new SkyScriptActionHandler[128]
    Handlers8 = new SkyScriptActionHandler[128]
    Handlers9 = new SkyScriptActionHandler[128]
endEvent

_SkyScript_ActionHandlers function GetInstance() global
    return _SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_ActionHandlers
endFunction

int function AddHandler(SkyScriptActionHandler handler)
    int nextIndex = HandlerCount
    HandlerCount += 1
    if nextIndex < 128
        Handlers0[nextIndex] = handler
    else
        ; TODO
    endIf
    return nextIndex
endFunction

SkyScriptActionHandler function GetHandler(int index)
    if index < 128
        return Handlers0[index]
    else
        ; TODO
    endIf
endFunction
