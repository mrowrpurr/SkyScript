scriptName _SkyScript_StdlibActionHandler extends SkyScriptActionHandler

; event RegisterActions() ; TODO REDO ACTION REGISTRATION NONSENSE
;     RegisterAction("msg")
;     RegisterAction("msgbox")
;     RegisterAction("print")
;     RegisterAction("var")
;     RegisterAction("blackscreen")
;     RegisterAction("fadetoblack")
;     RegisterAction("fadefromblack")
;     RegisterAction("wait")
;     RegisterAction("closeracemenu")
;     RegisterAction("prompt")
;     RegisterAction("event")
;     RegisterAction("script")
;     RegisterAction("notify")
; endEvent

int function Execute(int scriptInstance, string actionName, int actionInfo)
    if JMap.hasKey(actionInfo, "msg")
        return Message(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "msgbox")
        return MessageBox(actionInfo)
    elseIf JMap.hasKey(actionInfo, "if")
        return IfConditional(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "equal")
        return EqualCondition(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "print")
        return PrintConsole(actionInfo)
    elseIf JMap.hasKey(actionInfo, "var")
        return SetVariable(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "vars")
        return SetVariables(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "notify")
        return Notify(actionInfo)
    elseIf JMap.hasKey(actionInfo, "on")
        return OnEvent(actionInfo)
    elseIf JMap.hasKey(actionInfo, "event")
        return OnEvent(actionInfo)
    elseIf JMap.hasKey(actionInfo, "script")
        return RunScript(scriptInstance, actionInfo)
    elseIf JMap.hasKey(actionInfo, "wait")
        return Wait(actionInfo)
    elseIf JMap.hasKey(actionInfo, "prompt")
        return Prompt(scriptInstance, actionInfo)
    endIf

    return 0
endFunction

bool function MatchAction(int scriptInstance, int actionInfo)
    return JMap.hasKey(actionInfo, "msgbox") || \
           JMap.hasKey(actionInfo, "msg")    || \
           JMap.hasKey(actionInfo, "if")     || \
           JMap.hasKey(actionInfo, "equal")  || \
           JMap.hasKey(actionInfo, "var")    || \
           JMap.hasKey(actionInfo, "vars")   || \
           JMap.hasKey(actionInfo, "wait")   || \
           JMap.hasKey(actionInfo, "prompt") || \
           JMap.hasKey(actionInfo, "event")  || \
           JMap.hasKey(actionInfo, "on")     || \
           JMap.hasKey(actionInfo, "notify") || \
           JMap.hasKey(actionInfo, "print")  || \
           JMap.hasKey(actionInfo, "script")
endFunction

int function MessageBox(int actionInfo)
    string text = GetString(actionInfo, "text")
    if HasField(actionInfo, "msgbox")
        text = GetString(actionInfo, "msgbox")
    endIf
    Debug.MessageBox(text)
    return ReturnString(text)
endFunction

int function Notify(int actionInfo)
    string text = GetString(actionInfo, "text")
    if HasField(actionInfo, "notify")
        text = GetString(actionInfo, "notify")
    endIf
    Debug.Notification(text)
    return ReturnString(text)
endFunction

int function PrintConsole(int actionInfo)
    string text = GetString(actionInfo, "text")
    if HasField(actionInfo, "print")
        text = GetString(actionInfo, "print")
    endIf
    Debug.Notification(text)
    return ReturnString(text)
endFunction

int function SetVariables(int scriptInstance, int actionInfo)
    int variableMap = JMap.getObj(actionInfo, "vars")
    string[] variableNames = JMap.allKeysPArray(variableMap)
    int i = 0
    while i < variableNames.Length
        string variableName = variableNames[i]
        int variableType = JMap.valueType(variableMap, variableName)
        if variableType == 2
            _SkyScript_ScriptInstance.SetVariableInt(scriptInstance, variableName, JMap.getInt(variableMap, variableName))
        elseIf variableType == 3
            _SkyScript_ScriptInstance.SetVariableFloat(scriptInstance, variableName, JMap.getFlt(variableMap, variableName))
        elseIf variableType == 4
            _SkyScript_ScriptInstance.SetVariableForm(scriptInstance, variableName, JMap.getForm(variableMap, variableName))
        elseIf variableType == 5
            _SkyScript_ScriptInstance.SetVariableObject(scriptInstance, variableName, JMap.getObj(variableMap, variableName))
        elseIf variableType == 6
            _SkyScript_ScriptInstance.SetVariableString(scriptInstance, variableName, JMap.getStr(variableMap, variableName))
        endIf
        i += 1
    endWhile
endFunction

; JMap Types
; 2: int
; 3: float
; 4: Form
; 5: object
; 6: string
int function SetVariable(int scriptInstance, int actionInfo)
    ; validate etc...
    string varName = JMap.getStr(actioninfo, "var")

    ; Debug.MessageBox("TODO set variable " + varname + " type: " + JMap.valueType(actionInfo, "value") + " as string: " + JMap.getStr(actionInfo, "value"))

    ; Is the variable a literal "value" or does it equal the "result" of running something?
    if JMap.hasKey(actionInfo, "value")
        int valueType = JMap.valueType(actionInfo, "value")
        if valueType == 2
            _SkyScript_ScriptInstance.SetVariableInt(scriptInstance, varName, JMap.getInt(actionInfo, "value"))
        elseIf valueType == 3
            _SkyScript_ScriptInstance.SetVariableFloat(scriptInstance, varName, JMap.getFlt(actionInfo, "value"))
        elseIf valueType == 4
            _SkyScript_ScriptInstance.SetVariableForm(scriptInstance, varName, JMap.getForm(actionInfo, "value"))
        elseIf valueType == 5
            _SkyScript_ScriptInstance.SetVariableObject(scriptInstance, varName, JMap.getObj(actionInfo, "value"))
        elseIf valueType == 6
            _SkyScript_ScriptInstance.SetVariableString(scriptInstance, varName, JMap.getStr(actionInfo, "value"))
        endIf
    endIf

    return 0

    if JMap.hasKey(actionInfo, "result")
        Debug.MessageBox("Unsupported var from result")
        int subscriptDefinitinion = JMap.getObj(actioninfo, "result")

    endIf
endFunction

int function BlackScreen(int actionInfo)
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    fadeToBlackHold.Apply()
    return ReturnNone()
endFunction

int function FadeToBlack(int actionInfo)
    ImageSpaceModifier fadeToBlack = Game.GetForm(0xf756d) as ImageSpaceModifier
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    float waitBeforeHold = JMap.getFlt(actionInfo, "wait", 2.0)
    fadeToBlack.Apply()
    Utility.Wait(waitBeforeHold)
    fadeToBlack.PopTo(fadeToBlackHold)
    return ReturnNone()
endFunction

int function FadeFromBlack(int actionInfo)
    ImageSpaceModifier fadeFromBlack = Game.GetForm(0xf756f) as ImageSpaceModifier
    ImageSpaceModifier fadeToBlackHold = Game.GetForm(0xf756e) as ImageSpaceModifier
    fadeToBlackHold.PopTo(FadeFromBlack)
    fadeToBlackHold.Remove()
    return ReturnNone()
endFunction

int function Wait(int actionInfo)
    float time = GetFloat(actionInfo, "duration")
    if HasField(actionInfo, "wait")
        time = GetFloat(actionInfo, "wait")
    endIf
    if GetBool(actionInfo, "menu")
        Utility.WaitMenuMode(time)
    else
        Utility.Wait(time)
    endIf
    return ReturnFloat(time)
endFunction

; TODO - update to run actions as subscripts instead of just running an action (so they can be paused)
int function Message(int scriptInstance, int actionInfo)    
    ; TODO syntax errors, validation, etc

    _SkyScript_Quest ss = _SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_Quest
    
    ; Set the message Text
    string text = _SkyScript_ScriptInstance.InterpolateString(scriptInstance, JMap.getStr(actionInfo, "msg"))
    ss.SkyrimScripting_MessageText_BaseForm.SetName(text)

    ; Reset all message buttons
    bool anyButtons = false
    if JMap.hasKey(actionInfo, "back")
        ss.SkyrimScripting_Message_Generic_Back.Value = 1
        anyButtons = true
    else
        ss.SkyrimScripting_Message_Generic_Back.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "yes")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Yes.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Yes.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "no")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_No.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_No.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "default")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Default.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Default.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "continue")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Continue.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Continue.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "next")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Next.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Next.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "exit")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Exit.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Exit.Value = 0
    endIf
    if JMap.hasKey(actionInfo, "cancel")
        anyButtons = true
        ss.SkyrimScripting_Message_Generic_Cancel.Value = 1
    else
        ss.SkyrimScripting_Message_Generic_Cancel.Value = 0
    endIf

    ; TODO ! Add an explicit "OK" option ?
    int back = 0
    int yes = 1
    int no = 2
    int default = 3
    int continue = 6
    int next = 7
    int exit = 8
    int cancel = 9

    int result = ss.SkyrimScripting_Message_Generic.Show()

    if ! anyButtons
        return ReturnString("OK")
    endIf

    string resultText
    int resultAction
    if result == back
        resultAction = JMap.getObj(actionInfo, "back")
        resultText = "back"
    elseIf result == yes
        resultAction = JMap.getObj(actionInfo, "yes")
        resultText = "yes"
    elseIf result == no
        resultAction = JMap.getObj(actionInfo, "no")
        resultText = "no"
    elseIf result == default
        resultAction = JMap.getObj(actionInfo, "default")
        resultText = "default"
    elseIf result == continue
        resultAction = JMap.getObj(actionInfo, "continue")
        resultText = "continue"
    elseIf result == next
        resultAction = JMap.getObj(actionInfo, "next")
        resultText = "next"
    elseIf result == exit
        resultAction = JMap.getObj(actionInfo, "exit")
        resultText = "exit"
    elseIf result == cancel || result == -1
        resultAction = JMap.getObj(actionInfo, "cancel")
        resultText = "cancel"
    endIf

    if resultAction
        _SkyScript_ScriptInstance.AddAndRunActionSubScript(scriptInstance, actionInfo, resultAction)
    else
        Debug.MessageBox("NO ACTION REGISTERED FOR RESULT: " + resultText)
    endIf

    return ReturnString(resultText)
endFunction

; TODO - update to run actions as subscripts instead of just running an action (so they can be paused)
int function Prompt(int scriptInstance, int actionInfo)
    ; TODO Raise a SyntaxError if missing prompt or options

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    int optionMap = JMap.getObj(actionInfo, "options")
    int choicesArray = JMap.getObj(actionInfo, "prompt")
    int choiceCount = JArray.count(choicesArray)
    int i = 0
    while i < choiceCount
        string choiceText = JArray.getStr(choicesArray, i)
        listMenu.AddEntryItem(choiceText)
        i += 1
    endWhile
    listMenu.OpenMenu()
    int resultIndex = listMenu.GetResultInt()
    string resultText
    if resultIndex == -1
        resultText = "Cancel"
    else
        resultText = JArray.getStr(choicesArray, resultIndex)
    endIf
    int resultAction = JMap.getObj(optionMap, resultText)
    if resultAction
        _SkyScript_ScriptInstance.AddAndRunActionSubScript(scriptInstance, actionInfo, resultAction)
    else
        Debug.MessageBox("NO ACTION REGISTERED FOR RESULT: " + resultText)
    endIf
    return ReturnString(resultText)
endFunction

int function OnEvent(int actionInfo)
    ; TODO validata params and such
    string eventName
    if JMap.hasKey(actionInfo, "event")
        eventName = JMap.getStr(actionInfo, "event")
    elseIf JMap.hasKey(actionInfo, "on")
        eventName = JMap.getStr(actionInfo, "on")
    else
        ; Error, yo
        Debug.MessageBox("Invalid event " + _SkyScript_Log.ToJson(actionInfo)) ; TODO make this a SyntaxError
    endIf

    int eventScript = JMap.getObj(actionInfo, "run")

    _SkyScript_Events.AddEventHandler(eventName, eventScript)

    return ReturnString(eventName)
endFunction

int function RunScript(int scriptInstance, int actionInfo)

    ; TODO run a script by file path
    
    return 0
endFunction

int function CloseRaceMenu(int actionInfo)
    ; This 100% assumes that you're in RaceMenu
    int enter = 28
    int accept = 19 ; R
    Input.TapKey(accept)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(enter)
    Utility.WaitMenuMode(0.1)
    Input.TapKey(enter)
    return ReturnNone()
endFunction

int function IfConditional(int scriptInstance, int actionInfo)
    int condition = JMap.getObj(actionInfo, "if")
    bool result = ResponseBool(RunCondition(scriptInstance, condition))
    if result
        if JMap.hasKey(actionInfo, "then")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
            _SkyScript_ScriptInstance.SetActionArray(subscript, JMap.getObj(actionInfo, "then"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(true)
    else
        if JMap.hasKey(actionInfo, "else")
            int subscript = _SkyScript_ScriptInstance.Initialize()
            _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
            _SkyScript_ScriptInstance.SetActionArray(subscript, JMap.getObj(actionInfo, "else"))
            _SkyScript_ScriptInstance.Run(subscript)
        endIf
        return ReturnBool(false)
    endIf
endFunction

int function RunCondition(int scriptInstance, int condition)
    int subscript = _SkyScript_ScriptInstance.Initialize()
    _SkyScript_ScriptInstance.SetParent(subscript, scriptInstance)
    _SkyScript_ScriptInstance.SetActionArray(subscript, condition)
    return _SkyScript_ScriptInstance.Run(subscript)
endFunction

int function EqualCondition(int scriptInstance, int actionInfo)
    int equalityCheck = JMap.getObj(actionInfo, "equal")

    string leftHandSideAsString
    int leftHandSideValueType = JArray.valueType(equalityCheck, 0)
    if leftHandSideValueType == 2 ; Int
        leftHandSideAsString = JArray.getInt(equalityCheck, 0)
    elseIf leftHandSideValueType == 3 ; Float
        leftHandSideAsString = JArray.getFlt(equalityCheck, 0)
    elseIf leftHandSideValueType == 4 ; Form
        leftHandSideAsString = JArray.getForm(equalityCheck, 0)
    elseIf leftHandSideValueType == 5 ; Object
        leftHandSideAsString = JArray.getObj(equalityCheck, 0)
    elseIf leftHandSideValueType == 6 ; String
        leftHandSideAsString = JArray.getStr(equalityCheck, 0)
    endIf

    string rightHandSideAsString
    int rightHandSideValueType = JArray.valueType(equalityCheck, 1)
    if rightHandSideValueType == 2 ; Int
        rightHandSideAsString = JArray.getInt(equalityCheck, 1)
    elseIf rightHandSideValueType == 3 ; Float
        rightHandSideAsString = JArray.getFlt(equalityCheck, 1)
    elseIf rightHandSideValueType == 4 ; Form
        rightHandSideAsString = JArray.getForm(equalityCheck, 1)
    elseIf rightHandSideValueType == 5 ; Object
        rightHandSideAsString = JArray.getObj(equalityCheck, 1)
    elseIf rightHandSideValueType == 6 ; String
        rightHandSideAsString = JArray.getStr(equalityCheck, 1)
    endIf

    string leftText = _SkyScript_ScriptInstance.InterpolateString(scriptInstance, leftHandSideAsString)
    string rightText = _SkyScript_ScriptInstance.InterpolateString(scriptInstance, rightHandSideAsString)

    return ReturnBool(leftText == rightText)
endFunction
