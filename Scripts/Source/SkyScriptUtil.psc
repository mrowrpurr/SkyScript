scriptName SkyScriptUtil

int function String_RFind(string source, string searchText) global
    int lastIndex = -1
    int nextIndex = StringUtil.Find(source, searchText)
    while nextIndex != -1
        lastIndex = nextIndex
        nextIndex = StringUtil.Find(source, searchText, lastIndex + 1)
    endWhile
    return lastIndex
endFunction

string function FindFile(string filePath, string extension = ".json") global
    if JContainers.fileExistsAtPath(filePath)
        return filePath
    elseIf JContainers.fileExistsAtPath("Data/" + filePath)
        return "Data/" + filePath
    elseIf JContainers.fileExistsAtPath("Data/SkyScript/" + filePath)
        return "Data/SkyScript/" + filePath
    elseIf JContainers.fileExistsAtPath(filePath + extension)
        return filePath + extension
    elseIf JContainers.fileExistsAtPath("Data/" + filePath + extension)
        return "Data/" + filePath + extension
    elseIf JContainers.fileExistsAtPath("Data/SkyScript/" + filePath + extension)
        return "Data/SkyScript/" + filePath + extension
    else
        return ""
    endIf
endFunction

int function GetSubObject(int object, string path) global

endFunction
