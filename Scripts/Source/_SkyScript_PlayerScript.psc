scriptName _SkyScript_PlayerScript extends ReferenceAlias hidden

; Add: EnterSneak and LeaveSneak via ability, as well as EnterCombat and LeaveCombat

event OnInit()
    ListenForEvents()
endEvent

event OnPlayerLoadGame()
    (GetOwningQuest() as _SkyScript_Quest).OnPlayerLoadGame()
    ; Delegate load game events to listening scripts!
    ListenForEvents()
endEvent

function ListenForEvents()
    ; RegisterForMenu("")
endFunction

event OnItemAdded(Form item, int count, ObjectReference ref, ObjectReference source)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setInt(eventVar, "count", count)
    JMap.setForm(eventVar, "object", ref)
    JMap.setForm(eventVar, "container", source)
    _SkyScript_Events.FireEventHandlers("Player/ItemAdded", eventVar)
endEvent

event OnItemRemoved(Form item, int count, ObjectReference ref, ObjectReference source)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setInt(eventVar, "count", count)
    JMap.setForm(eventVar, "object", ref)
    JMap.setForm(eventVar, "container", source)
    _SkyScript_Events.FireEventHandlers("Player/ItemRemoved", eventVar)
endEvent

event OnObjectEquipped(Form item, ObjectReference ref)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setForm(eventVar, "object", ref)
    _SkyScript_Events.FireEventHandlers("Player/ObjectEquipped", eventVar)
endEvent

event OnObjectUnequipped(Form item, ObjectReference ref)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setForm(eventVar, "object", ref)
    _SkyScript_Events.FireEventHandlers("Player/ObjectUnequipped", eventVar)
endEvent

event OnHit(ObjectReference aggressor, Form source, Projectile theProjectile, bool powerAttack, bool sneakAttack, bool bashAttack, bool hitBlocked)
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "aggressor", aggressor)
    JMap.setForm(eventVar, "source", source)
    JMap.setForm(eventVar, "projectile", theProjectile)
    JMap.setInt(eventVar, "powerAttack", powerAttack as int)
    JMap.setInt(eventVar, "sneakAttack", sneakAttack as int)
    JMap.setInt(eventVar, "bashAttack", bashAttack as int)
    JMap.setInt(eventVar, "hitBlocked", hitBlocked as int)
    _SkyScript_Events.FireEventHandlers("Player/Hit", eventVar)
endEvent
