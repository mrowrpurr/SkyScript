scriptName _SkyScript_PlayerScript extends ReferenceAlias hidden

event OnPlayerLoadGame()
    (GetOwningQuest() as _SkyScript_Quest).OnPlayerLoadGame()
endEvent
