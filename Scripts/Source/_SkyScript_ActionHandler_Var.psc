scriptName _SkyScript_ActionHandler_Var extends SkyScriptActionHandler

event RegisterSyntax()
    AddSyntax("var")
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string[] actionSyntaxKeys = JMap.allKeysPArray(actionInfo)

    ; Is it variable shorthand?
    if actionSyntaxKeys.Length == 1
        string keyName = actionSyntaxKeys[0]
        string varName
        if SkyScriptUtil.String_EndsWith(keyName, " =")
            varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 2)
        elseIf SkyScriptUtil.String_EndsWith(keyName, " = ")
            varName = StringUtil.Substring(keyName, 0, StringUtil.GetLength(keyName) - 3)
        endIf
        if varName
            ; The value of this key is a literal variable value
            int valueType = JMap.valueType(actionInfo, keyName)
            if valueType == 2 ; Int
                int value = JMap.getInt(actionInfo, keyName)
                SkyScript.SetVariableInt(scriptInstance, varName, value)
                return ReturnInt(value)
            elseIf valueType == 3 ; Float
                float value = JMap.getFlt(actionInfo, keyName)
                SkyScript.SetVariableFloat(scriptInstance, varName, value)
                return ReturnFloat(value)
            elseIf valueType == 4 ; Form
                Form value = JMap.getForm(actionInfo, keyName)
                SkyScript.SetVariableForm(scriptInstance, varName, value)
                return ReturnForm(value)
            elseIf valueType == 5 ; Object
                int value = JMap.getObj(actionInfo, keyName)
                SkyScript.SetVariableObject(scriptInstance, varName, value)
                return ReturnObject(value)
            elseIf valueType == 6 ; String
                string value = JMap.getStr(actionInfo, keyName)
                SkyScript.SetVariableString(scriptInstance, varName, value)
                return ReturnString(value)
            endIf
        endIf
        if SkyScriptUtil.String_EndsWith(keyName, " =>") || SkyScriptUtil.String_EndsWith(keyName, " => ")
            ; The value of this key is an expression to be evaluated

        endIf
    endIf

    string varName = GetString(actioninfo, "var")

    ; if "get" get it from sub-object or Form!

    if JMap.hasKey(actionInfo, "value")
        int valueType = JMap.valueType(actionInfo, "value")
        if valueType == 2 ; Int
            int value = JMap.getInt(actionInfo, "value")
            SkyScript.SetVariableInt(scriptInstance, varName, value)
            return ReturnInt(value)
        elseIf valueType == 3 ; Float
            float value = JMap.getFlt(actionInfo, "value")
            SkyScript.SetVariableFloat(scriptInstance, varName, value)
            return ReturnFloat(value)
        elseIf valueType == 4 ; Form
            Form value = JMap.getForm(actionInfo, "value")
            SkyScript.SetVariableForm(scriptInstance, varName, value)
            return ReturnForm(value)
        elseIf valueType == 5 ; Object
            int value = JMap.getObj(actionInfo, "value")
            SkyScript.SetVariableObject(scriptInstance, varName, value)
            return ReturnObject(value)
        elseIf valueType == 6 ; String
            string value = JMap.getStr(actionInfo, "value")
            SkyScript.SetVariableString(scriptInstance, varName, value)
            return ReturnString(value)
        endIf
    endIf

    string filePath
    string objectPath 

    if JMap.hasKey(actionInfo, "from")
        filePath = JMap.getStr(actionInfo, "from")
        objectPath = JMap.getStr(actionInfo, "get")
    elseIf JMap.hasKey(actionInfo, "get") ; "get" is the file if no "from" is provided and the full file is provided 
        filePath = JMap.getStr(actionInfo, "get")
    endIf

    if filePath
        filePath = SkyScriptUtil.FindFile(filePath)
    endIf

    MiscUtil.PrintConsole("File path: " + filePath)

    if JContainers.fileExistsAtPath(filePath)
        int fileContent = JValue.readFromFile(filePath)
        if objectPath
            MiscUtil.PrintConsole("Object path?")
            return ReturnString("Dunno how to do this...")
        else
            MiscUtil.PrintConsole("Setting variable to the file content")
            SkyScript.SetVariableObject(scriptInstance, varName, fileContent)
            return ReturnObject(fileContent)
        endIf
    else
        MiscUtil.PrintConsole("File not found " + filePath)
        return 0
    endIf
endFunction