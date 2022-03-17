#pragma once

#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/VariableImpl.h"

namespace SkyScript::Interpreter::Variables {

    namespace {

    }

    void AddOrUpdateVariableInContext(SkyScriptNode& node, ContextImpl& context) {
        std::string variableType = "stdlib::string";
        std::string variableName = node.GetSingleKey();
        variableName = variableName.substr(0, variableName.length() - 2); // 2 for " ="

        auto rightmostSpace = variableName.rfind(' ');

        if (rightmostSpace != std::string::npos) {
            variableType = variableName.substr(0, rightmostSpace);
            variableName = variableName.substr(rightmostSpace + 1);
        }

        auto value = TypedValueImpl(variableType, node.GetSingleValue().GetStringValue());
        auto variable = VariableImpl(variableName, variableType, value);

        context.AddVariable(variable);
    }
}
