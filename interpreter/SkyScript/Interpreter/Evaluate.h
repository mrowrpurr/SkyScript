#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/ContextImpl.h"

namespace SkyScript::Interpreter {

    namespace {
        bool IsFunctionDefinition(SkyScriptNode& node) {
            return node.IsMap() && node.Size() == 1 && node.GetSingleKey().ends_with("()");
        }
    }

    bool Evaluate(SkyScriptNode& node, ContextImpl& context) {
        // Check for function definition
        if (IsFunctionDefinition(node)) {
//            auto functionName = key.substr(0, key.size() - 2);
        } else {
            context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", node.toString()));
        }
        return false;
    }
}
