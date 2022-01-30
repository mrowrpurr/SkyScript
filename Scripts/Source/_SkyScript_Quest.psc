scriptName _SkyScript_Quest extends Quest hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Initialization and Save Game Loading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Quest function GetSkyrimScriptingQuest() global
    return Quest.GetQuest("SkyrimScripting") as Quest
endFunction

event OnInit()
    CurrentlyInstalledVersion = SkyScript.GetVersion()
    Utility.WaitMenuMode(0.5) ; TODO configure
    _SkyScript_Events.RunStartupScripts()
endEvent

event OnPlayerLoadGame()
    ; TODO
    _SkyScript_Events.RunStartupScripts()
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Versioning
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string property CurrentlyInstalledVersion auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
