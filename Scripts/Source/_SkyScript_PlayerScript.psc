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
    ListenForMenus()    
endFunction

function ListenForMenus()
    string[] menuNames = GetAllValidMenuNames()
    int i = 0
    while i < menuNames.Length
        string menuName = menuNames[i]
        string menuScriptsPath = _SkyScript_Files.MenuScriptsPath(menuName)
        if JContainers.fileExistsAtPath(menuScriptsPath)
            RegisterForMenu(menuName)
        endIf
        i += 1
    endWhile
endFunction

event OnMenuOpen(string menuName)
    int eventVar = JMap.object()
    JMap.setStr(eventVar, "menu", menuName)
    JMap.setInt(eventVar, "open", true as int)
    _SkyScript_Events.FireEventHandlers("Menus/" + menuName, eventVar)
endEvent

event OnMenuClose(string menuName)
    int eventVar = JMap.object()
    JMap.setStr(eventVar, "menu", menuName)
    JMap.setInt(eventVar, "close", true as int)
    _SkyScript_Events.FireEventHandlers("Menus/" + menuName, eventVar)
endEvent

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

string[] function GetAllValidMenuNames() global
    string[] menuNames = new string[36]
    menuNames[0] = "BarterMenu"
    menuNames[1] = "Book Menu"
    menuNames[2] = "Console"
    menuNames[3] = "Console Native UI Menu"
    menuNames[4] = "ContainerMenu"
    menuNames[5] = "Crafting Menu"
    menuNames[6] = "Credits Menu"
    menuNames[7] = "Cursor Menu"
    menuNames[8] = "Debug Text Menu"
    menuNames[9] = "Dialogue Menu"
    menuNames[10] = "Fader Menu"
    menuNames[11] = "FavoritesMenu"
    menuNames[12] = "GiftMenu"
    menuNames[13] = "HUD Menu"
    menuNames[14] = "InventoryMenu"
    menuNames[15] = "Journal Menu"
    menuNames[16] = "Kinect Menu"
    menuNames[17] = "LevelUp Menu"
    menuNames[18] = "Loading Menu"
    menuNames[19] = "Lockpicking Menu"
    menuNames[20] = "MagicMenu"
    menuNames[21] = "Main Menu"
    menuNames[22] = "MapMenu"
    menuNames[23] = "MessageBoxMenu"
    menuNames[24] = "Mist Menu"
    menuNames[25] = "Overlay Interaction Menu"
    menuNames[26] = "Overlay Menu"
    menuNames[27] = "Quantity Menu"
    menuNames[28] = "RaceSex Menu"
    menuNames[29] = "Sleep Wait Menu"
    menuNames[30] = "StatsMenu"
    menuNames[31] = "TitleSequence Menu"
    menuNames[32] = "Top Menu"
    menuNames[33] = "Training Menu"
    menuNames[34] = "Tutorial Menu"
    menuNames[35] = "TweenMenu"
    return menuNames
endfunction
