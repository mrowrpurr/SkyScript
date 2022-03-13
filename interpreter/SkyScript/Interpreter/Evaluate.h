#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/ContextImpl.h"

namespace SkyScript::Interpreter {
    bool Evaluate(SkyScriptNode&, ContextImpl&);
}
