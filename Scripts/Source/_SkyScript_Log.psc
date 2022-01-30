scriptName _SkyScript_Log hidden

string function ToJson(int object) global
    string fileName = SkyScript.DirectoryPath() + "/.tmp/tmp.json"
    JValue.writeToFile(object, fileName)
    return MiscUtil.ReadFromFile(fileName)
endFunction
