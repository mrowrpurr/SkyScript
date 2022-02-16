scriptName _SkyScript_Data hidden
{Responsible for storing a variety of data in the save game,
e.g. actively running contexts

Wraps JContainers' JDB storage for container data structures.}

string function GetPath(string path = "") global
    if path
        return ".skyScript." + "path" 
    else
        return ".skyScript"
    endIf
endFunction

int function GetObject(string path, int default = 0) global
    return JDB.solveObj(GetPath(path), default)
endFunction

function StoreObject(string path, int object) global
    JDB.solveObjSetter(GetPath(path), object, createMissingKeys = true)
endFunction

int function FindOrCreateMap(string path) global
    int object = GetObject(path)
    if ! object
        object = JMap.object()
        StoreObject(path, object)
    endIf
    return object
endFunction

int function FindOrCreateArray(string path) global
    int object = GetObject(path)
    if ! object
        object = JArray.object()
        StoreObject(path, object)
    endIf
    return object
endFunction
