scriptName _SkyScript_ActionHandler_AddSpell extends SkyScriptActionHandler

string property ACTION_KEY = "addspell" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int scriptInstance, int actionInfo)
    bool verbose   = GetBool(actionInfo, "verbose", true)
    Actor target   = GetActor(scriptInstance, actionInfo, "actor", Game.GetPlayer())
    Spell theSpell = GetSpell(scriptInstance, actionInfo, ACTION_KEY)

    if theSpell
        target.AddSpell(theSpell, verbose)
    endIf
endFunction
