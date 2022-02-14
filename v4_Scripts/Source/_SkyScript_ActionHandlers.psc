scriptName _SkyScript_ActionHandlers extends Quest

bool property IsReady auto

int property HandlerCount auto ; TODO make this a JArray of AVAILABLE indexes so we can deregister. Which WILL require locking to interact with.

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
    IsReady = true
endEvent

_SkyScript_ActionHandlers function GetInstance() global
    _SkyScript_ActionHandlers handlers = _SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_ActionHandlers
    while ! handlers.IsReady
        Utility.WaitMenuMode(0.05)
    endWhile
    return handlers
endFunction

; TODO switch to use a JContainers array of 'availableIndices' so we can Register and Unregister
int function AddHandler(SkyScriptActionHandler handler)
    int nextIndex = HandlerCount
    HandlerCount += 1
    if nextIndex < 128
        Handlers0[nextIndex] = handler
    else
        ; TODO
        Debug.MessageBox("Whoops, we haven't supported > 128 handlers yet!")
    endIf
    return nextIndex
endFunction

SkyScriptActionHandler function GetHandler(int index)
    if index < 128
        return Handlers0[index]
    else
        ; TODO
        Debug.MessageBox("Whoops, we haven't supported > 128 handlers yet!")
    endIf
endFunction
