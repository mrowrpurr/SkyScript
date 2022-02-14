scriptName _SkyScript_ActionHandler_AddSpell extends SkyScriptActionHandler

string property ACTION_KEY = "addspell" autoReadonly

event RegisterSyntax()
    AddSyntax(ACTION_KEY)
endEvent

int function Execute(int script, int actionInfo)
    bool verbose   = GetBool(actionInfo, "verbose", true)
    Actor target   = GetActor(script, actionInfo, "actor", Game.GetPlayer())
    Spell theSpell = GetSpell(script, actionInfo, ACTION_KEY)

    if theSpell
        target.AddSpell(theSpell, verbose)
    endIf
endFunction
