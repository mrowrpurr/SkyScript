scriptName _SkyScript_Thread extends Quest hidden

_SkyScript_Thread function GetThreadByIndex(int threadIndex) global
    return Quest.GetQuest("SkyrimScripting_Thread" + threadIndex) as _SkyScript_Thread
endFunction

int function GetNextThreadIndex() global
    return (_SkyScript_Quest.GetSkyrimScriptingQuest() as _SkyScript_Quest).GetNextThreadIndex()
endFunction

function RunJob(int jobId) global
    int threadIndex = GetNextThreadIndex()
    int eventModEvent = ModEvent.Create(ModEventNameForThreadIndex(threadIndex))
    ModEvent.PushInt(eventModEvent, jobId)
    ModEvent.Send(eventModEvent)
endFunction

string function ModEventNameForThreadIndex(int index) global
    return "SkyScriptThreadEvent__SkyScript_Thread" + index
endFunction

string _threadId

string property ThreadId
    string function get()
        if ! _threadId ; [ScriptName < (0000aabb)>]
            _threadId = StringUtil.SubString(self, 1, StringUtil.Find(self, " ") - 1)
        endIf
        return _threadId
    endFunction
endProperty

string property ModEventName
    string function get()
        return "SkyScriptThreadEvent_" + ThreadId
    endFunction
endProperty

event OnInit()
    ListenForJobs()
endEvent

function ListenForJobs()
    RegisterForModEvent(ModEventName, "OnJob")
endFunction

event OnJob(int jobId)
    string jobType = JMap.getStr(jobId, "type")
    if jobType == "eventHandler"
        OnEventHandler(jobId)
    endIf
endEvent

event OnEventHandler(int jobId)
    int eventHandler = JMap.getObj(jobId, "eventHandler")
    int scriptInstance = _SkyScript_ScriptInstance.Initialize()
    _SkyScript_ScriptInstance.SetActionArray(scriptInstance, eventHandler)
    _SkyScript_Runner.ResumeScriptInstance(scriptInstance)
    _SkyScript_ScriptInstance.Dispose(scriptInstance)
    _SkyScript_Events.CompleteJob(jobId)
endEvent
; JMap.setStr(jobId, "type", "eventHandler")
; JMap.setStr(jobId, "eventName", eventName)
; JMap.setObj(jobId, "eventHandler", eventHandler)
; JMap.setObj(jobId, "event", eventVariable)
; return jobId
