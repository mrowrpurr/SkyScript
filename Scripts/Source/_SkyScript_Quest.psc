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
    InitializeThreads()
    ListenForEventHandlers()
    Utility.WaitMenuMode(1) ; TODO CONFIGURE THIS! ADD SOME WAITING SOMEPLACE!
    _SkyScript_Events.RunStartupScripts()

    ; Testing...
    ; ListenForTestingKeyboardShortcuts()
endEvent

event OnPlayerLoadGame()
    ListenForEventHandlers()
    _SkyScript_Events.RunStartupScripts() ; How to make these so they only run once (IF SO DESIRED?)
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Versioning
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string property CurrentlyInstalledVersion auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Threaded Event Handling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

int _nextThreadIndex
_SkyScript_Thread[] property Threads auto

int function GetNextThreadIndex()
    int index = _nextThreadIndex
    if index == 9
        _nextThreadIndex = 0
    else
        _nextThreadIndex += 1
    endIf
    return index
endFunction

function InitializeThreads()
    Threads = new _SkyScript_Thread[10]
    Threads[0] = _SkyScript_Thread.GetThreadByIndex(0)
    Threads[1] = _SkyScript_Thread.GetThreadByIndex(1)
    Threads[2] = _SkyScript_Thread.GetThreadByIndex(2)
    Threads[3] = _SkyScript_Thread.GetThreadByIndex(3)
    Threads[4] = _SkyScript_Thread.GetThreadByIndex(4)
    Threads[5] = _SkyScript_Thread.GetThreadByIndex(5)
    Threads[6] = _SkyScript_Thread.GetThreadByIndex(6)
    Threads[7] = _SkyScript_Thread.GetThreadByIndex(7)
    Threads[8] = _SkyScript_Thread.GetThreadByIndex(8)
    Threads[9] = _SkyScript_Thread.GetThreadByIndex(9)
endFunction

function ListenForEventHandlers()
    Threads[0].ListenForJobs()
    Threads[1].ListenForJobs()
    Threads[2].ListenForJobs()
    Threads[3].ListenForJobs()
    Threads[4].ListenForJobs()
    Threads[5].ListenForJobs()
    Threads[6].ListenForJobs()
    Threads[7].ListenForJobs()
    Threads[8].ListenForJobs()
    Threads[9].ListenForJobs()
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; KEYBOARD SHORTCUTS FOR TESTING (TEMPORARY)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; function ListenForTestingKeyboardShortcuts()
;     RegisterForKey(199)    ; Start Script - Home
;     RegisterForKey(197)    ; Pause It - Pause
;     RegisterForKey(210)    ; Print Status - Ins
;     RegisterForKey(207)    ; End it - End
;     RegisterForKey(211)    ; Resume it - Del
; endFunction

; int currentTestScript

; event OnKeyDown(int keyCode)
;     if keyCode == 199 ; Start
;         currentTestScript = SkyScript.Initialize("Data/hello.json")
;         Debug.MessageBox("RUNNING " + currentTestScript)
;         SkyScript.Run(currentTestScript)
;         if ! SkyScript.IsPaused(currentTestScript)
;             SkyScript.Dispose(currentTestScript)
;         endIf
;     elseIf keyCode == 197 ; Pause
;         Debug.MessageBox("PAUSING " + currentTestScript)
;         SkyScript.Pause(currentTestScript)
;     elseIf keyCode == 210 ; Status
;         Debug.MessageBox("STATUS OF SCRIPT " + currentTestScript + "\n" + _SkyScript_Log.ToJson(currentTestScript))
;     elseIf keyCode == 207 ; End
;         Debug.MessageBox("STOPPING " + currentTestScript)
;         SkyScript.Kill(currentTestScript)
;     elseIf keyCode == 211 ; Resume
;         Debug.MessageBox("RESUMING " + currentTestScript)
;         SkyScript.Resume(currentTestScript)
;     endIf
    
;     _SkyScript_Log.DumpData()
; endEvent
