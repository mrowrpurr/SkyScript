scriptName _SkyScript_Quest extends Quest hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Generic MessageBox
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Message property SkyrimScripting_Message_Generic auto
GlobalVariable property SkyrimScripting_Message_Generic_Back auto
GlobalVariable property SkyrimScripting_Message_Generic_Yes auto
GlobalVariable property SkyrimScripting_Message_Generic_No auto
GlobalVariable property SkyrimScripting_Message_Generic_Default auto
GlobalVariable property SkyrimScripting_Message_Generic_Continue auto
GlobalVariable property SkyrimScripting_Message_Generic_Next auto
GlobalVariable property SkyrimScripting_Message_Generic_Exit auto
GlobalVariable property SkyrimScripting_Message_Generic_Cancel auto
Form property SkyrimScripting_MessageText_BaseForm auto

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
