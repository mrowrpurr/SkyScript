scriptName _SkyScript_Log hidden

string function ToJson(int object) global
    if ! object
        return ""
    endIf
    string fileName = SkyScript.DirectoryPath() + "/.tmp/tmp.json"
    JValue.writeToFile(object, fileName)
    string text = ""
    string textWithNewlines = MiscUtil.ReadFromFile(fileName)
    string[] lines = StringUtil.Split(textWithNewlines, "\n")
    int i = 0
    while i < lines.Length
        if i == 0
            text += lines[i]
        else
            text += " " + lines[i]
        endIf
        i += 1
    endWhile
    return text
endFunction

string function DumpData() global
    JValue.writeToFile(_SkyScript_Data.GetStore(), "SkyScriptData.json")
endFunction
