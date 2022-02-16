scriptName _SkyScript_ClassParser hidden

function ParseAndImportTypesFile(int context, string filePath) global
    if context && filePath && JContainers.fileExistsAtPath(filePath)
        int fileContent = JValue.readFromFile(filePath)
        if fileContent
            AddTempFileContentDuringParsing(fileContent)
            if JValue.isArray(fileContent)
                int count = JArray.count(fileContent)
                if count
                    int i = 0
                    while i < count
                        int classDefinition = JArray.getObj(fileContent, i)
                        if classDefinition
                            ParseAndImportClassDefinition(context, classDefinition)
                        endIf
                        i += 1
                    endWhile
                endIf
            else
                ParseAndImportClassDefinition(context, fileContent)
            endIf
            DisposeTempFileContent(fileContent)
        endIf
    endIf
endFunction

function ParseAndImportClassDefinition(int context, int classDefinition) global
    if context && classDefinition && JValue.isMap(classDefinition) && JMap.hasKey(classDefinition, "class")
        string className = JMap.getStr(classDefinition, "class")
        if className
            int type = JMap.object()
            _SkyScript_Contexts.AddTypeDefinition(context, type)
            JMap.setStr(type, "name", className)
            if JMap.count(classDefinition) > 1
                string[] keyNames = JMap.allKeysPArray(classDefinition)
                int i = 0
                while i < keyNames.Length
                    string keyName = keyNames[i]
                    ParseAndImportClassDefinitionItem(context, type, keyName)
                    i += 1
                endWhile
            endIf
        endIf
    endIf
endFunction

function ParseAndImportClassDefinitionItem(int context, int type, string keyName) global
    if context && type && keyName

        bool isStatic
        if StringUtil.Find(keyName, "static ") == 0
            isStatic = true
            keyName = StringUtil.Substring(keyName, 7) ; "static " --> 7
        endIf

        bool isPrivate
        if StringUtil.Find(keyName, "_") == 0
            isPrivate = true
        endIf

        bool isFunction
        int parensIndex = StringUtil.Find(keyName, "()")
        if parensIndex
            isFunction = true
            keyName = StringUtil.Substring(keyName, 0, parensIndex) + StringUtil.Substring(keyname, parensIndex + 2) ; "()" --> 2
        endIf

        ; YOU ARE HERE

    endIf
endFunction

function AddTempFileContentDuringParsing(int fileContent) global
    if fileContent
        JMap.setObj(TempFileContentStorage(), fileContent, fileContent)
    endIf
endFunction

function DisposeTempFileContent(int fileContent) global
    if fileContent
        JMap.removeKey(TempFileContentStorage(), fileContent)
    endIf
endFunction

int function TempFileContentStorage() global
    return _SkyScript_Data.FindOrCreateMap("classParser.tempFileContent")
endFunction
