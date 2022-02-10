scriptName _SkyScript_ActionHandler_ConsoleCmd extends SkyScriptActionHandler
{Action to define console command handlers!}

; "console-command": "name of command"
; "aliases": ["optional", "aliases"],
; "run": {ACTION} which will have variables set: args, argCount, argsText

int function Execute(int scriptInstance, int actionInfo)
    string commandName = JMap.getStr(actionInfo, "console-command")
    int aliases = JMap.getObj(actionInfo, "aliases")
    ; int action = GetAction(actionInfo, "run") ; <--- TODO
    int runAction = JMap.getObj(actionInfo, "run")
    ; Register as a command
    ; And register this action as a handler :)
endFunction
