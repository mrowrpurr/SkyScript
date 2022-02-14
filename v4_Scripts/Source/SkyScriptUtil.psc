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

bool function String_EndsWith(string source, string searchText) global
    if (! source) || (! searchText)
        return false
    endIf
    int sourceLength = StringUtil.GetLength(source)
    int searchLength = StringUtil.GetLength(searchText)
    if searchLength > sourceLength
        return false
    endIf
    string endOfSourceText = StringUtil.Substring(source, sourceLength - searchLength)
    return endOfSourceText == searchText
endFunction

; TODO move this out of here? it's not generic? I dunno. undecided.
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
