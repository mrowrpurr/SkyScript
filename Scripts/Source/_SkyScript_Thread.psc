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
    Debug.MessageBox("Cool, " + ThreadId + " received a job! " + _SkyScript_Log.ToJson(jobId))
endEvent
