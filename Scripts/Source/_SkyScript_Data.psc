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

int function Store(string path, int object) global
    JDB.solveObjSetter(GetPath(path), object, createMissingKeys = true) 
    return object
endFunction

int function Clear(string path) global 
    ; TODO
    return 0
endFunction

int function StoreDirectory(string path, string directory) global
    if MiscUtil.FileExists(directory)
        return Store(path, JValue.readFromDirectory(directory))
    else
        return Clear(path)
    endIf
endFunction
