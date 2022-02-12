scriptName _SkyScript_ActionHandler_LoadFile extends Quest

; TODO REMOVE - DUPLICATE WITH 'GET' ACTIOn

; string property ACTION_KEY = "loadfile" autoReadonly

; event RegisterSyntax()
;     AddSyntax(ACTION_KEY)
; endEvent

; int function Execute(int scriptInstance, int actionInfo)
;     string filePath = SkyScriptUtil.FindFile(GetString(actionInfo, ACTION_KEY))
;     if JContainers.fileExistsAtPath(filePath)
;         return JValue.readFromFile(filePath)
;     else
;         return 0
;     endIf
; endFunction
