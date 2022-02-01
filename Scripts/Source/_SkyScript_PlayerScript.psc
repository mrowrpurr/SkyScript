scriptName _SkyScript_PlayerScript extends ReferenceAlias hidden

; Add: EnterSneak and LeaveSneak via ability, as well as EnterCombat and LeaveCombat

event OnPlayerLoadGame()
    (GetOwningQuest() as _SkyScript_Quest).OnPlayerLoadGame()
    ; Delegate load game events to listening scripts!
endEvent

event OnItemAdded(Form item, int count, ObjectReference ref, ObjectReference source)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setInt(eventVar, "count", count)
    JMap.setForm(eventVar, "object", ref)
    JMap.setForm(eventVar, "container", source)
    _SkyScript_Events.FireEventHandlers("ItemAdded", eventVar)
endEvent
