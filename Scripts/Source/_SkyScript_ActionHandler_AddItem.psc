scriptName _SkyScript_ActionHandler_AddItem extends SkyScriptActionHandler

string property ACTION_KEY = "additem" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    bool verbose = GetBool(actionInfo, "verbose", true)
    int count = GetInt(actionInfo, "count", 1)
    Actor target = GetActor(scriptInstance, actionInfo, "target", Game.GetPlayer())
    if count < 1
        return 0
    endIf
    if IsObject(actionInfo, ACTION_KEY)
        int response = RunAction(scriptInstance, GetObject(actionInfo, ACTION_KEY))
        if ResponseType(response) == "form"
            Form theForm = ResponseForm(response)
            target.AddItem(theForm, count, (! verbose))
        endIf
    elseIf IsString(actionInfo, ACTION_KEY)
        int response = SkyScript.GetVariable(scriptInstance, GetString(actionInfo, ACTION_KEY))
        if ResponseType(response) == "form"
            Form theForm = ResponseForm(response)
            target.AddItem(theForm, count, (! verbose))
        endIf
    endIf
endFunction