scriptName _SkyScript_Data hidden

string function GetPath(string path = "") global
    if path
        return ".skyScript" + "." + path
    else
        return ".skyScript"
    endIf
endFunction

int function GetStore() global
    int store = JDB.solveObj(GetPath())
    if ! store
        store = JMap.object()
        JDB.solveObjSetter(GetPath(), store, createMissingKeys = true) 
    endIf
    return store
endFunction

int function Get(string path) global
    return JDB.solveObj(GetPath(path))
endFunction

float function GetFloat(string path) global
    return JDB.solveFlt(GetPath(path))
endFunction

function Store(string path, int object) global
    JDB.solveObjSetter(GetPath(path), object, createMissingKeys = true) 
endFunction

function StoreFloat(string path, float value) global
    JDB.solveFltSetter(GetPath(path), value, createMissingKeys = true) 
endFunction

int function Clear(string path) global 
    ; TODO
    return 0
endFunction

int function StoreDirectory(string path, string directory) global
    if MiscUtil.FileExists(directory)
        int object = JValue.readFromDirectory(directory)
        Store(path, object)
        return object
    else
        return Clear(path)
    endIf
endFunction

int function FindOrCreateMap(string path) global
    int object = Get(path)
    if ! object
        object = JMap.object()
        Store(path, object)
    endIf
    return object
endFunction

int function FindOrCreateArray(string path) global
    int object = Get(path)
    if ! object
        object = JArray.object()
        Store(path, object)
    endIf
    return object
endFunction
