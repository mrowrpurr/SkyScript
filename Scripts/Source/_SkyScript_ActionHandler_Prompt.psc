scriptName _SkyScript_ActionHandler_Prompt extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("prompt")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    SkyScriptLock.AcquireLock("UIPrompt")

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    int optionMap = GetObject(actionInfo, "options")
    int choicesArray = GetObject(actionInfo, "prompt")
    int choiceCount = JArray.count(choicesArray)
    int i = 0
    while i < choiceCount
        string choiceText = SkyScript.InterpolateString(scriptInstance, JArray.getStr(choicesArray, i))
        listMenu.AddEntryItem(choiceText)
        i += 1
    endWhile
    listMenu.OpenMenu()
    int resultIndex = listMenu.GetResultInt()
    
    SkyScriptLock.ReleaseLock("UIPrompt")

    string resultText
    if resultIndex == -1
        resultText = "Cancel"
    else
        resultText = JArray.getStr(choicesArray, resultIndex)
    endIf
    int resultAction = JMap.getObj(optionMap, resultText)
    if resultAction
        _SkyScript_ScriptInstance.AddAndRunActionSubScript(scriptInstance, actionInfo, resultAction)
    endIf

    return ReturnString(resultText)
endFunction
