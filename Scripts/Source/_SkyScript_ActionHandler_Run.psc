scriptName _SkyScript_ActionHandler_Run extends SkyScriptActionHandler

string property ACTION_KEY = "run" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    string scriptPath = GetString(actionInfo, ACTION_KEY)
    scriptPath = SkyScriptUtil.FindFile(scriptPath)
    if scriptPath
        SkyScript.RunFile(scriptPath)
    endIf
endFunction
