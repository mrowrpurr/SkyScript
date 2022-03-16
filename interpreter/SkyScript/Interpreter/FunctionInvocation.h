#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h"
#include "SkyScript/Interpreter/FunctionParser.h"
#include "SkyScript/Interpreter/NativeFunctions.h"

namespace SkyScript::Interpreter::FunctionInvocation {
    namespace {

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

        // Load up the params!

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
