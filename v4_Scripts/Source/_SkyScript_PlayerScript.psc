scriptName _SkyScript_PlayerScript extends ReferenceAlias hidden

; Add: EnterSneak and LeaveSneak via ability, as well as EnterCombat and LeaveCombat

bool property ListenFor_OnItemAdded auto
bool property ListenFor_OnItemRemoved auto
bool property ListenFor_OnObjectEquipped auto
bool property ListenFor_OnObjectUnequipped auto
bool property ListenFor_OnHit auto

string property FolderFor_OnItemAdded = "Player/ItemAdded" autoReadonly
string property FolderFor_OnItemRemoved = "Player/ItemRemoved" autoReadonly
string property FolderFor_OnObjectEquipped = "Player/ObjectEquipped" autoReadonly
string property FolderFor_ObjectUnequipped = "Player/ObjectUnequipped" autoReadonly
string property FolderFor_OnHit = "Player/Hit" autoReadonly

event OnInit()
    ListenForEvents()
endEvent

event OnPlayerLoadGame()
    (GetOwningQuest() as _SkyScript_Quest).OnPlayerLoadGame()
    ; Delegate load game events to listening scripts!
    ListenForEvents()
endEvent

function ListenForEvents()
    ListenFor_OnItemAdded = JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnItemAdded))
    ListenFor_OnItemRemoved = JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnItemRemoved))
    ListenFor_OnObjectEquipped = JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnObjectEquipped))
    ListenFor_OnObjectUnequipped = JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnObjectEquipped))
    ListenFor_OnHit = JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnHit))

    ; TODO - we need this to COUNT active handlers (fun times) because these handlers can be registered via code. oof.
    ; ListenFor_OnItemAdded = true ;JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnItemAdded))
    ; ListenFor_OnItemRemoved = true ;JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnItemRemoved))
    ; ListenFor_OnObjectEquipped = true ;JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnObjectEquipped))
    ; ListenFor_OnObjectUnequipped = true ;JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnObjectEquipped))
    ; ListenFor_OnHit = true ;JContainers.fileExistsAtPath(_SkyScript_Files.EventScriptsDirectory(FolderFor_OnHit))

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
    if ! ListenFor_OnItemAdded
        return
    endIf
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setInt(eventVar, "count", count)
    JMap.setForm(eventVar, "object", ref)
    JMap.setForm(eventVar, "container", source)
    _SkyScript_Events.FireEventHandlers(FolderFor_OnItemAdded, eventVar)
endEvent

event OnItemRemoved(Form item, int count, ObjectReference ref, ObjectReference source)
    if ! ListenFor_OnItemAdded
        return
    endIf
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setInt(eventVar, "count", count)
    JMap.setForm(eventVar, "object", ref)
    JMap.setForm(eventVar, "container", source)
    _SkyScript_Events.FireEventHandlers(FolderFor_OnItemRemoved, eventVar)
endEvent

event OnObjectEquipped(Form item, ObjectReference ref)
    if ! ListenFor_OnObjectEquipped
        return
    endIf
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setForm(eventVar, "object", ref)
    _SkyScript_Events.FireEventHandlers(FolderFor_OnObjectEquipped, eventVar)
endEvent

event OnObjectUnequipped(Form item, ObjectReference ref)
    if ! ListenFor_OnObjectUnequipped
        return
    endIf
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "item", item)
    JMap.setForm(eventVar, "object", ref)
    _SkyScript_Events.FireEventHandlers(FolderFor_ObjectUnequipped, eventVar)
endEvent

event OnHit(ObjectReference aggressor, Form source, Projectile theProjectile, bool powerAttack, bool sneakAttack, bool bashAttack, bool hitBlocked)
    if ! ListenFor_OnHit
        return
    endIf
    int eventVar = JMap.object()
    JMap.setForm(eventVar, "aggressor", aggressor)
    JMap.setForm(eventVar, "source", source)
    JMap.setForm(eventVar, "projectile", theProjectile)
    JMap.setInt(eventVar, "powerAttack", powerAttack as int)
    JMap.setInt(eventVar, "sneakAttack", sneakAttack as int)
    JMap.setInt(eventVar, "bashAttack", bashAttack as int)
    JMap.setInt(eventVar, "hitBlocked", hitBlocked as int)
    _SkyScript_Events.FireEventHandlers(FolderFor_OnHit, eventVar)
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
