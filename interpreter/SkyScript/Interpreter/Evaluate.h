#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/ContextImpl.h"

namespace SkyScript::Interpreter {

    namespace {
        bool IsFunctionDefinition(SkyScriptNode& node) {
            return node.IsMap() && node.Size() == 1 && node.GetSingleKey().ends_with("()");
        }
        void AddFunctionToContext(SkyScriptNode& node, ContextImpl& context) {
            std::string functionName;
            std::string functionNamespace;

            auto functionNameKey = node.GetSingleKey();
            auto fullFunctionName = functionNameKey.substr(0, functionNameKey.size() - 2); // 2 for "()"
            auto namespaceSeparatorIndex = fullFunctionName.rfind("::");
            if (namespaceSeparatorIndex == std::string::npos) {
                functionName = fullFunctionName;
            } else {
                functionNamespace = fullFunctionName.substr(0, namespaceSeparatorIndex);
                functionName = fullFunctionName.substr(namespaceSeparatorIndex + 2);
            }

            auto functionInfo = FunctionInfoImpl(functionNamespace, functionName);
            context.AddFunction(functionInfo);
        }
    }

    bool Evaluate(SkyScriptNode& node, ContextImpl& context) {
        // Check for function definition
        if (IsFunctionDefinition(node)) {
            AddFunctionToContext(node, context);
        } else {
            context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", node.toString()));
        }
        return false;
    }
}
