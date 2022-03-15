#pragma once

#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"
#include "SkyScript/Reflection/Impl/FunctionParameterInfoImpl.h"

namespace SkyScript::Interpreter::FunctionParser {

    std::string GetDocString(SkyScriptNode& map) {
        auto key = ":";
        if (map.ContainsKey(key) && map[key].IsString()) {
            std::string docString = map[key].GetStringValue();
            SkyScript::Interpreter::Util::trim(docString);
            return docString;
        }
        auto altKey = ":desc:";
        if (map.ContainsKey(altKey) && map[altKey].IsString()) {
            std::string docString = map[altKey].GetStringValue();
            SkyScript::Interpreter::Util::trim(docString);
            return docString;
        }
        return "";
    }
    bool GetIsNative(SkyScriptNode& map) {
        return map.ContainsKey(":native") || map.ContainsKey(":native:");
    }
    void AddParameterToFunction(FunctionInfoImpl& function, SkyScriptNode& paramNode) {
        auto param = FunctionParameterInfoImpl();
        for (const auto& key : paramNode.GetKeys()) {
            std::cout << std::format("PARAM KEY '{}' EQUALS '{}'", key, paramNode[key].GetStringValue());
            if (key == ":" || key == ":desc:") {
                param.SetDocString(GetDocString((paramNode)));
            } else {
                param.SetName(key);
                param.SetTypeName(paramNode[key].GetStringValue());
            }
        }
        std::cout << std::format("PARAM FOUND w/ NAME '{}' ", param.GetName());
        if (! param.GetName().empty()) {
            function.AddParameter(param);
        }
    }
    void AddParametersToFunction(FunctionInfoImpl& function, SkyScriptNode& map) {
        if (map.ContainsKey("params")) {
            auto& paramsNode = map["params"];
            if (paramsNode.IsArray()) {
                for (int i = 0; i < paramsNode.Size(); i++) {
                    auto& paramNode = paramsNode[i];
                    AddParameterToFunction(function, paramNode);
                }
            }
        }
    }
    void AddFunctionToContext(SkyScriptNode& node, ContextImpl& context) {
        auto key = node.GetSingleKey();
        std::string functionName = key.substr(0, key.size() - 2); // 2 for "()"
        std::string functionNamespace;
        std::string functionReturnType = "void";

        // Check for return type
        auto rightmostSpace = functionName.rfind(' ');
        if (rightmostSpace != std::string::npos) {
            // Get everything left of the " " space as the return type
            functionReturnType = functionName.substr(0, rightmostSpace);
            // The function name, itself, is everything to the right of the " " space
            functionName = functionName.substr(rightmostSpace + 1);
        }

        // Check for namespace
        auto namespaceSeparatorIndex = functionName.rfind("::");
        if (namespaceSeparatorIndex != std::string::npos) {
            functionNamespace = functionName.substr(0, namespaceSeparatorIndex);
            functionName = functionName.substr(namespaceSeparatorIndex + 2);
        }

        auto functionInfo = FunctionInfoImpl(functionNamespace, functionName);

        functionInfo.SetReturnTypeName(functionReturnType);

        auto& map = node.GetSingleValue();
        if (map.IsMap()) {
            functionInfo.SetDocString(GetDocString(map));
            functionInfo.SetIsNative(GetIsNative(map));
            AddParametersToFunction(functionInfo, map);
        }

        context.AddFunction(functionInfo);
    }
}
