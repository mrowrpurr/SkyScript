#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/Util.h"
#include "SkyScript/Interpreter/ContextImpl.h"

namespace SkyScript::Interpreter {

    static const std::string_view DOCSTRING_KEY = ":";
    static const std::string_view DOCSTRING_KEY_ALT = ":desc";

    namespace {
        bool IsFunctionDefinition(SkyScriptNode& node) {
            return node.IsMap() && node.Size() == 1 && node.GetSingleKey().ends_with("()");
        }
        std::string GetFunctionDocString(SkyScriptNode& node) {
            auto& map = node.GetSingleValue();
            if (map.IsMap()) {
                auto key = DOCSTRING_KEY.data();
                if (map.ContainsKey(key) && map[key].IsString()) {
                    std::string docString = map[key].GetStringValue();
                    SkyScript::Interpreter::Util::trim(docString);
                    return docString;
                }
                auto altKey = DOCSTRING_KEY_ALT.data();
                if (map.ContainsKey(altKey) && map[altKey].IsString()) {
                    std::string docString = map[altKey].GetStringValue();
                    SkyScript::Interpreter::Util::trim(docString);
                    return docString;
                }
            }
            return "";
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
            functionInfo.SetDocString(GetFunctionDocString(node));

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
