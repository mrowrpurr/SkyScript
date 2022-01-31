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

    ; Testing...
    ListenForTestingKeyboardShortcuts()
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
; KEYBOARD SHORTCUTS FOR TESTING (TEMPORARY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function ListenForTestingKeyboardShortcuts()
    RegisterForKey(199)    ; Start Script - Home
    RegisterForKey(197)    ; Pause It - Pause
    RegisterForKey(210)    ; Print Status - Ins
    RegisterForKey(207)    ; End it - End
    RegisterForKey(211)    ; Resume it - Del
endFunction

int currentTestScript

event OnKeyDown(int keyCode)
    if keyCode == 199 ; Start
        currentTestScript = SkyScript.Initialize("Data/hello.json")
        Debug.MessageBox("RUNNING " + currentTestScript)
        SkyScript.Run(currentTestScript)
    elseIf keyCode == 197 ; Pause
        Debug.MessageBox("PAUSING " + currentTestScript)
        SkyScript.Pause(currentTestScript)
    elseIf keyCode == 210 ; Status
        Debug.MessageBox("STATUS OF SCRIPT " + currentTestScript + "\n" + _SkyScript_Log.ToJson(currentTestScript))
    elseIf keyCode == 207 ; End
        Debug.MessageBox("STOPPING " + currentTestScript)
        SkyScript.Kill(currentTestScript)
    elseIf keyCode == 211 ; Resume
        Debug.MessageBox("RESUMING " + currentTestScript)
        SkyScript.Resume(currentTestScript)
    endIf
    
    _SkyScript_Log.DumpData()
endEvent
