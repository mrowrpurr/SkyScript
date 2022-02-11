scriptName _SkyScript_ActionHandler_ReadFile extends Quest ; SkyScriptActionHandler

; event RegisterSyntax()
;     AddSyntax("readFile")
; endEvent

; int function Execute(int scriptInstance, int actionInfo)
;     string filePath = JMap.getStr(actionInfo, "readFile")
;     bool found = JContainers.fileExistsAtPath(filePath)

;     ; if (! found) 

;     if (! found) && StringUtil.Find(filePath, "Data") != 0
;         filePath = "Data/" + filePath
;         found = JContainers.fileExistsAtPath(filePath)
;     endIf

;     if (! found) && JContainers.fileExistsAtPath("SkyScript/" + filePath)
;         filePath = "SkyScript/" + filePath
;         found = true
;     endIf

;     if found
;         return JValue.readFromFile(filePath)
;     else
;         return 0
;     endIf
; endFunction
