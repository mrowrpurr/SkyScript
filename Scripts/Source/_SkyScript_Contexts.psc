scriptName _SkyScript_Contexts hidden
{Private functions for Contexts}

int function NewContext(int parent) global
    int context = JMap.object()
    if parent
        AddSubcontext(parent, context)
    else
        AddTopLevelContext(context)
    endIf
    JMap.setObj(context, "subcontexts", JMap.object())
    JMap.setObj(context, "variables", JMap.object())
    JMap.setObj(context, "types", JMap.object())
    return context
endFunction

int function TopLevelContextsMap() global
    return _SkyScript_Data.FindOrCreateMap("topLevelContexts")
endFunction

function AddTopLevelContext(int context) global
    if context
        JMap.setObj(TopLevelContextsMap(), context, context)
    endIf
endFunction

function DisposeTopLevelContext(int context) global
    if context
        JMap.removeKey(TopLevelContextsMap(), context)
    endIf
endFunction

function AddSubcontext(int parent, int context) global
    if parent && context
        JMap.setObj(JMap.getObj(parent, "subcontexts"), context, context)
    endIf
endFunction

function RemoveSubcontext(int parent, int context) global
    if parent && context
        JMap.removeKey(JMap.getObj(parent, "subcontexts"), context)
    endIf
endFunction

function AddTypeDefinition(int context, int classDefinition) global

endFunction
