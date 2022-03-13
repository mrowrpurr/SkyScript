#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/ContextImpl.h"

namespace SkyScript::Interpreter {

    namespace {
        bool IsFunctionDefinition(SkyScriptNode& node) {
            return node.IsMap() && node.Size() == 1 && node.GetSingleKey().ends_with("()");
        }
        std::string GetFunctionName(SkyScriptNode& node) {
            auto functionNameKey = node.GetSingleKey();
            return functionNameKey.substr(0, functionNameKey.size() - 2); // 2 for "()"
        }
    }

    bool Evaluate(SkyScriptNode& node, ContextImpl& context) {
        // Check for function definition
        if (IsFunctionDefinition(node)) {
            auto functionName = GetFunctionName(node);
            auto functionInfo = FunctionInfoImpl("", functionName);
            context.AddFunction(functionInfo);
        } else {
            context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", node.toString()));
        }
        return false;
    }
}
