scriptName SkyScriptLock hidden

function AcquireLock(string lockName, float lock = 0.0, float waitInterval = 0.01) global
    string lockpath = "locks." + lockName

    if ! lock
        lock = Utility.RandomFloat(1, 10000000)
    endIf

    while _SkyScript_Data.GetFloat(lockPath)
        Utility.WaitMenuMode(waitInterval)
    endWhile

    ; Try to acquire the lock
    _SkyScript_Data.StoreFloat(lockPath, lock)

    ; Check a few times if we have the lock - because we're fighting the other threads
    if _SkyScript_Data.GetFloat(lockPath) == lock
        if _SkyScript_Data.GetFloat(lockPath) == lock
            ; Good! Lock Acquired!
        else
            AcquireLock(lockName, lock, waitInterval)
        endIf
    else
        AcquireLock(lockName, lock, waitInterval)
    endIf
endFunction

function ReleaseLock(string lockName) global
    string lockpath = "locks." + lockName
    _SkyScript_Data.StoreFloat(lockPath, 0)
endFunction
