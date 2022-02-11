scriptName _SkyScript_ActionHandler_Get extends Quest ; SkyScriptActionHandler

; event RegisterSyntax()
;     AddSyntax("get")
; endEvent

; ; Foo/Bar/Baz.foo.bar.baz
; int function Execute(int scriptInstance, int actionInfo)
;     string filePath
;     string objectPath 

;     if JMap.hasKey(actionInfo, "from")
;         filePath = JMap.getStr(actionInfo, "from")
;         objectPath = JMap.getStr(actionInfo, "get")
;     else ; "get" is the file if no "from" is provided and the full file is provided 
;         filePath = JMap.getStr(actionInfo, "get")
;     endIf

;     filePath = SkyScriptUtil.FindFile(filePath)

;     if JContainers.fileExistsAtPath(filePath)
;         int fileContent = JValue.readFromFile(filePath)
;         if objectPath

;         else
;             return fileContent
;         endIf
;     else
;         return 0
;     endIf
; endFunction
