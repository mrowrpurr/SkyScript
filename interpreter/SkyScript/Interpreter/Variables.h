#pragma once

#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/VariableInfoImpl.h"

namespace SkyScript::Interpreter::Variables {

    namespace {

    }

    void AddOrUpdateVariableInContext(SkyScriptNode& node, ContextImpl& context) {
        std::string variableType;
        std::string variableName = node.GetSingleKey();
        variableName = variableName.substr(0, variableName.length() - 2); // 2 for " ="

        auto rightmostSpace = variableName.rfind(' ');

        if (rightmostSpace != std::string::npos) {
            variableType = variableName.substr(0, rightmostSpace);
            variableName = variableName.substr(rightmostSpace + 1);
        }

        auto& nodeValue = node.GetSingleValue();

        if (variableType.empty()) {
            if (nodeValue.IsString()) {
                variableType = "stdlib::string";
            } else if (nodeValue.IsInteger()) {
                variableType = "stdlib::int";
            } else if (nodeValue.IsFloat()) {
                variableType = "stdlib::float";
            } else if (nodeValue.IsBool()) {
                variableType = "stdlib::bool";
            }
        }

        auto variableValue = TypedValueImpl(variableType);
        if (variableType == "int" || variableType == "stdlib::int") {
            variableValue.SetValue(nodeValue.GetIntValue());
        } else if (variableType == "float" || variableType == "stdlib::float") {
                variableValue.SetValue(nodeValue.GetFloatValue());
        } else if (variableType == "bool" || variableType == "stdlib::bool") {
            variableValue.SetValue(nodeValue.GetBoolValue());
        } else {
            variableValue.SetValue(nodeValue.GetStringValue());
        }
        auto variable = VariableInfoImpl(variableName, variableType, variableValue);

        context.AddVariable(variable);
    }
}
