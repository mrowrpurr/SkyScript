scriptName _SkyScript_Quest extends Quest hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Initialization and Save Game Loading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event OnInit()
    CurrentlyInstalledVersion = SkyScript.GetVersion()
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
