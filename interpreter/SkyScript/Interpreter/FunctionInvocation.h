#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h"
#include "SkyScript/Interpreter/FunctionParser.h"
#include "SkyScript/Interpreter/NativeFunctions.h"

namespace SkyScript::Interpreter::FunctionInvocation {

    void AddParameter(FunctionParameterInfo& functionParam, SkyScriptNode& invocationProvidedValueNode, FunctionInfo&, FunctionInvocationParamsImpl& invocationParams, SkyScriptNode&, Reflection::Context& context) {
        if (! invocationProvidedValueNode.IsValue()) {
            spdlog::info("Expected param node to be value/scalar! '{}' ", invocationProvidedValueNode.toString());
            // KABOOM!
        }

        auto paramName = functionParam.GetName();
        std::string typeName = functionParam.GetTypeName();
        std::string stringValue = invocationProvidedValueNode.GetStringValue();

        if (stringValue.starts_with('$')) {
            auto variableName = invocationProvidedValueNode.GetStringValue().substr(1); // Remove $
            if (context.VariableExists(variableName)) {
                auto& variable = context.GetVariable(variableName);
                typeName = variable.GetTypeName();
                if (typeName == "string" || typeName == "stdlib::string") {
                    invocationParams.AddStringParameter(paramName, variable.GetTypedValue().GetStringValue());
                } else if (typeName == "int" || typeName == "stdlib::int") {
                        invocationParams.AddIntParameter(paramName, variable.GetTypedValue().GetIntValue());
                } else if (typeName == "float" || typeName == "stdlib::float") {
                    invocationParams.AddFloatParameter(paramName, variable.GetTypedValue().GetFloatValue());
                } else if (typeName == "bool" || typeName == "stdlib::bool") {
                    invocationParams.AddBoolParameter(paramName, variable.GetTypedValue().GetBoolValue());
                } else {
                    spdlog::info("Variable type not supported {}", typeName);
                    // TODO
                }
                return;
            } else {
                spdlog::info("Variable not found: {}", paramName);
                // KABOOM!
            }
        } else if (stringValue.starts_with("\\\\$")) {
            stringValue = stringValue.substr(1); // Skip the starting \ character
        } else if (stringValue.starts_with("\\$")) {
            stringValue = stringValue.substr(1); // Skip the starting \ character
        }

        // TODO use context.Types() to lookup type, e.g. privitive typed without namespacing *CAN* be changed in theory
        // But for now, just handle the primitives specifically
        if (typeName == "stdlib::string" || typeName == "string") {
            invocationParams.AddStringParameter(paramName, stringValue);
        } else if (typeName == "stdlib::int" || typeName == "int") {
            invocationParams.AddIntParameter(paramName, invocationProvidedValueNode.GetIntValue());
        } else if (typeName == "stdlib::float" || typeName == "float") {
            invocationParams.AddFloatParameter(paramName, invocationProvidedValueNode.GetFloatValue());
        } else if (typeName == "stdlib::bool" || typeName == "bool") {
            invocationParams.AddBoolParameter(paramName, invocationProvidedValueNode.GetBoolValue());
        } else {
            spdlog::info("Custom types unsupported.");
        }
}

    void AddInlineParameter(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {
        if (function.GetParameterCount() == 1) {
            AddParameter(function.GetParameter(0), node, function, params, node, context);
        } else {
            // KABOOM
        }
    }

    void AddNamedParameters(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {
        for (const auto& paramName : function.GetParameterNames()) {
            AddParameter(function.GetParameter(paramName), node[paramName], function, params, node, context);
        }
    }

    void AddPositionalParameters(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {
        if (function.GetParameterCount() != node.Size()) {
            // KABOOM
            // ... actually ... check for default values! ...
            //
            // the count might be diff because of default values!
        }

        auto paramCount = function.GetParameterCount();
        for (int i = 0; i < paramCount; i++) {
            AddParameter(function.GetParameter(i), node[i], function, params, node, context);
        }
    }

    void InvokeNativeFunction(SkyScriptNode& node, Reflection::Context& context, const std::string& functionName, const std::string& nativeFunctionName) {
        if (! context.FunctionExists(functionName)) {
            // KABOOM!
            spdlog::info("Oh jeez, function doesn't exist '{}'", functionName);
        }

        auto& nativeFunctions = NativeFunctions::GetSingleton();
        if (! nativeFunctions.HasFunction(nativeFunctionName)) {
            // KABOOM!
            spdlog::info("Oh jeez, NATIVE function doesn't exist '{}'", nativeFunctionName);
        }

        auto& fn = context.GetFunctionInfo(functionName);
        auto params = FunctionInvocationParamsImpl(context, fn, node);

        if (node.HasSingleValue()) {
            auto& value = node.GetSingleValue();
            if (value.IsValue()) {
                AddInlineParameter(fn, params, value, context);
            } else if (value.IsMap()) {
                AddNamedParameters(fn, params, value, context);
            } else if (value.IsArray()) {
                AddPositionalParameters(fn, params, value, context);
            }
        }

        nativeFunctions.InvokeFunction(nativeFunctionName, params);
    }

    void InvokeFunction(SkyScriptNode& node, Reflection::Context& context) {
        spdlog::info("Invoke Function {}", node.toString());

        auto functionName = node.GetSingleKey();
        if (! context.FunctionExists(functionName)) {
            // KABOOM
        }

        auto& functionInfo = context.GetFunctionInfo(functionName);
        if (functionInfo.IsNative()) {
            auto nativeFunctionName = functionInfo.GetNativeFunctionName();
            InvokeNativeFunction(node, context, functionName, nativeFunctionName);
        } else {
            spdlog::info("Oh jeez! Can't invoke function because it's not native! {}", functionName);
            // TODO ...
        }
    }
}
