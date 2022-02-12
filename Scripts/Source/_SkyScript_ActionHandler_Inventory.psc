scriptName _SkyScript_ActionHandler_Inventory extends SkyScriptActionHandler

; string property GETINVENTORY_KEY = "getinventory" autoReadonly ; TODO
; string property SAVEINVENTORY_KEY = "saveinventory" autoReadonly
string property SAVEEQUIPPED_KEY = "saveequipped" autoReadonly

event RegisterSyntax()
    ; AddSyntax(SAVEINVENTORY_KEY)
    AddSyntax(SAVEEQUIPPED_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    if HasField(actionInfo, SAVEEQUIPPED_KEY)
        MiscUtil.PrintConsole("YES, SAVE EQUIPPED")
        string filePath = GetString(actionInfo, SAVEEQUIPPED_KEY)
        MiscUtil.PrintConsole("Save to: " + filePath)
        Actor target = GetActor(scriptInstance, actionInfo, "target", Game.GetPlayer())
        SaveEquippedItems(target, filePath)
    endIf    
endFunction

function SaveEquippedItems(Actor target, string filePath)
    int items = JArray.object()
    JValue.retain(items)

    int itemCount = target.GetNumItems()
    int i = 0
    while i < itemCount
        Form item = target.GetNthForm(i)
        if target.IsEquipped(item)
            JArray.addForm(items, item)
        endIf
        i += 1
    endWhile

    MiscUtil.PrintConsole("Writing " + filePath)
    JValue.writeToFile(items, filePath)
    JValue.release(items)
endFunction
