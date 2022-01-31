scriptName _SkyScript_Log hidden

string function ToJson(int object) global
    if ! object
        return ""
    endIf

    string fileName = SkyScript.DirectoryPath() + "/.tmp/tmp.json"
    JValue.writeToFile(object, fileName)
    return MiscUtil.ReadFromFile(fileName)
endFunction

string function DumpData() global
    JValue.writeToFile(_SkyScript_Data.GetStore(), "SkyScriptData.json")
endFunction
