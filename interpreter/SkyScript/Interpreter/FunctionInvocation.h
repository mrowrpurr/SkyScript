#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h"
#include "SkyScript/Interpreter/FunctionParser.h"
#include "SkyScript/Interpreter/NativeFunctions.h"

namespace SkyScript::Interpreter::FunctionInvocation {

    void AddParameter(FunctionParameterInfo& functionParam, SkyScriptNode& invocationProvidedValueNode, FunctionInfo&, FunctionInvocationParamsImpl& invocationParams, SkyScriptNode&, Reflection::Context&) {
        if (! invocationProvidedValueNode.IsValue()) {
            spdlog::info("Expected param node to be value/scalar! '{}' ", invocationProvidedValueNode.toString());
            // KABOOM!
        }

        auto paramName = functionParam.GetName();
        auto typeName = functionParam.GetTypeName();

        // TODO use context.Types() to lookup type, e.g. privitive typed without namespacing *CAN* be changed in theory
        // But for now, just handle the primitives specifically
        if (typeName == "stdlib::string" || typeName == "string") {
            invocationParams.AddStringParameter(paramName, invocationProvidedValueNode.GetStringValue());
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
        spdlog::info("Add inline param, fn params {} ", function.GetParameterCount());
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
                spdlog::info("- IS VALUE -");
                AddInlineParameter(fn, params, value, context);
            } else if (value.IsMap()) {
                spdlog::info("- IS MAP -");
                AddNamedParameters(fn, params, value, context);
            } else if (value.IsArray()) {
                spdlog::info("- IS ARRAY -");
                AddPositionalParameters(fn, params, value, context);
            }
        }

        nativeFunctions.InvokeFunction(nativeFunctionName, params);
    }

    void InvokeFunction(SkyScriptNode& node, Reflection::Context& context) {
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
