scriptName _SkyScript_ActionHandler_Log extends SkyScriptActionHandler

string property ACTION_KEY = "log" autoReadonly
; string property LOG_PATH_VARNAME = "LOG_PATH" autoReadonly
; string property LOG_LEVEL_VARNAME = "LOG_LEVEL" autoReadonly
; string property LOG_LEVEL_DEFAULT_NAME = "INFO" autoReadonly
; string property LOG_LEVEL_TRACE_NAME = "TRACE" autoReadonly
; string property LOG_LEVEL_DEBUG_NAME = "DEBUG" autoReadonly
; string property LOG_LEVEL_INFO_NAME = "INFO" autoReadonly
; string property LOG_LEVEL_WARN_NAME = "WARN" autoReadonly
; string property LOG_LEVEL_ERROR_NAME = "ERROR" autoReadonly
; string property LOG_LEVEL_FATAL_NAME = "FATAL" autoReadonly
; int property LOG_LEVEL_TRACE_ORDER = 0 autoReadonly
; int property LOG_LEVEL_DEBUG_ORDER = 1 autoReadonly
; int property LOG_LEVEL_INFO_ORDER = 2 autoReadonly
; int property LOG_LEVEL_WARN_ORDER = 3 autoReadonly
; int property LOG_LEVEL_ERROR_ORDER = 4 autoReadonly
; int property LOG_LEVEL_FATAL_ORDER = 5 autoReadonly

event RegisterSyntax()
    AddSyntax("log")
endEvent

int function Execute(int script, int expression)
    string text = GetString(expression, ACTION_KEY)
    MiscUtil.WriteToFile("SkyScript.log", text, append = true)

    ; TODO
    ; if text
    ;     if SkyScript.HasVariable(script, LOG_PATH_VARNAME)
    ;         string logPath = SkyScript.GetVariableString(script, LOG_PATH_VARNAME)
    ;         if logPath
    ;             string logLevel = SkyScript.GetVariableString(script, LOG_LEVEL_VARNAME, "info")

    ;         endIf
    ;     endIf
    ; endIf
endFunction
