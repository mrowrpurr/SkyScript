#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h"
#include "SkyScript/Interpreter/FunctionParser.h"
#include "SkyScript/Interpreter/NativeFunctions.h"

namespace SkyScript::Interpreter::FunctionInvocation {

    void AddInlineParameter(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {
        if (function.GetParameterCount() == 1) {
            auto& param = function.GetParameter(0);
            // TYPE CHECKING and conversions or whatever...
            params.AddParameter(param.GetName(), TypedValueImpl(param.GetTypeName(), node.GetStringValue()));
        } else {
            // KABOOM
        }
    }

    void AddNamedParameters(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {

    }

    void AddPositionalParameters(FunctionInfo& function, FunctionInvocationParamsImpl& params, SkyScriptNode& node, Reflection::Context& context) {

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

        spdlog::info("params: DOES NODE HAVE A VALUE??? {} ", node.HasSingleValue());
        if (node.HasSingleValue()) {
            auto& value = node.GetSingleValue();
            if (value.IsValue()) {
                spdlog::info("params: SCALAR VALUE! {}", value.GetStringValue());
                AddInlineParameter(fn, params, value, context);
            } else if (value.IsMap()) {
                spdlog::info("params: MAP! {} ", value.toString());
                AddNamedParameters(fn, params, value, context);
            } else if (value.IsArray()) {
                spdlog::info("params: ARRAY MAP! {} ", value.toString());
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
