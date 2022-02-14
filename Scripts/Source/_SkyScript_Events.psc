scriptName _SkyScript_Events hidden

function RunStartupScripts() global
    _SkyScript_Runner.RunDirectoryScripts(_SkyScript_Files.LoadStartupScripts(), _SkyScript_Files.StartupScriptsPath())
endFunction

function QueueJob(int jobId) global
    JMap.setObj(EventHandlersQueue(), jobId, jobId)
    _SkyScript_Thread.RunJob(jobId) ; TODO - when save games are loaded, ensure that the queue is resumed playing. I think it auto will be tho...
endFunction

function CompleteJob(int jobId) global
    JMap.removeKey(EventHandlersQueue(), jobId)
endFunction

function FireEventHandlers(string eventName, int eventVariable = 0) global
    int eventHandlers = GetEventHandlersArray(eventName) ; This is the list of known handlers
    if eventHandlers
        int handlerCount = JArray.count(eventHandlers)
        int i = 0
        while i < handlerCount
            int eventHandler = JArray.getObj(eventHandlers, i)
            int script = _SkyScript_ScriptInstance.Initialize()
            SkyScript.SetScriptActions(script, eventHandler)
            QueueJob(CreateEventHandlerJob(eventName, script, eventVariable))
            i += 1
        endWhile
    endIf

    FireScriptEventHandlers(eventName, eventVariable)
endFunction

function FireScriptEventHandlers(string eventName, int eventVariable = 0) global
    string[] scriptFiles = _SkyScript_Files.ScriptFilesForEvent(eventName)
    if scriptFiles
        int i = 0
        while i < scriptFiles.Length
            string filepath = scriptFiles[i]
            int script = SkyScript.Initialize(filepath)
            QueueJob(CreateEventHandlerJob(eventName, script, eventVariable))
            i += 1
        endWhile
    endIf
endFunction

int function CreateEventHandlerJob(string eventName, int script, int eventVariable = 0) global
    SkyScript.SetVariableObject(script, "event", eventVariable)
    int jobId = JMap.object()
    JMap.setStr(jobId, "type", "script")
    JMap.setObj(jobId, "script", script)
    return jobId
endFunction

function AddEventHandler(string eventName, int eventScript) global
    JArray.addObj(GetOrCreateEventHandlersArray(eventName), eventScript)
endFunction

int function GetOrCreateEventHandlersArray(string eventName) global
    int eventHandlersArray = GetEventHandlersArray(eventName)
    if ! eventHandlersArray
        eventHandlersArray = JArray.object()
        JMap.setObj(EventHandlersMap(), eventName, eventHandlersArray)
    endIf
    return eventHandlersArray
endFunction

int function GetEventHandlersArray(string eventName) global
    return JMap.getObj(EventHandlersMap(), eventName)
endFunction

int function EventHandlersMap() global
    return _SkyScript_Data.FindOrCreateMap("eventHandlers")
endFunction

int function EventHandlersQueue() global
    return _SkyScript_Data.FindOrCreateMap("eventHandlerQueue")
endFunction
