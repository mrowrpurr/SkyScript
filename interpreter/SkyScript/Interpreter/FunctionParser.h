#pragma once

#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"
#include "SkyScript/Reflection/Impl/FunctionParameterInfoImpl.h"

namespace SkyScript::Interpreter::FunctionParser {

    static const std::string_view DOCSTRING_KEY = ":";
    static const std::string_view DOCSTRING_KEY_ALT = ":desc:";

    static const std::string_view NATIVEFN_KEY = ":native";
    static const std::string_view NATIVEFN_KEY_ALT = ":native:";

    static const std::string_view PARAMS_KEY = "params";

    std::string GetDocString(SkyScriptNode& map) {
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
        return "";
    }
    bool GetIsNative(SkyScriptNode& map) {
        return map.ContainsKey(NATIVEFN_KEY.data()) || map.ContainsKey(NATIVEFN_KEY_ALT.data());
    }
    void AddParameterToFunction(FunctionInfoImpl& function, SkyScriptNode& paramNode) {
        auto param = FunctionParameterInfoImpl();
        for (const auto& key : paramNode.GetKeys()) {
            std::cout << std::format("PARAM KEY '{}' EQUALS '{}'", key, paramNode[key].GetStringValue());
            if (key == DOCSTRING_KEY.data() || key == DOCSTRING_KEY_ALT.data()) {
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
        if (map.ContainsKey(PARAMS_KEY.data())) {
            auto& paramsNode = map[PARAMS_KEY.data()];
            if (paramsNode.IsArray()) {
                for (int i = 0; i < paramsNode.Size(); i++) {
                    auto& paramNode = paramsNode[i];
                    AddParameterToFunction(function, paramNode);
                }
            }
        }
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

        auto& map = node.GetSingleValue();
        if (map.IsMap()) {
            functionInfo.SetDocString(GetDocString(map));
            functionInfo.SetIsNative(GetIsNative(map));
            AddParametersToFunction(functionInfo, map);
        }

        context.AddFunction(functionInfo);
    }
}
