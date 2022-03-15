#pragma once

#include <atomic>

#include "SkyScript/Reflection/FunctionInvocationResponse.h"
#include "SkyScript/Reflection/FunctionInvocationParams.h"

using namespace SkyScript::Reflection;

namespace SkyScript::Interpreter {

    class NativeFunctions {
        std::unordered_map<std::string, std::function<FunctionInvocationResponse(FunctionInvocationParams&)>> _functions;

        NativeFunctions() = default;

    public:
        NativeFunctions(const NativeFunctions&) = delete;
        NativeFunctions &operator=(const NativeFunctions&) = delete;

        static NativeFunctions& GetSingleton() {
            static NativeFunctions nativeFunctions;
            return nativeFunctions;
        }

        size_t Count() { return _functions.size(); }
        bool HasFunction(const std::string& functionName) { return _functions.contains(functionName); }

        void RegisterFunction(const std::string& functionName, std::function<FunctionInvocationResponse(FunctionInvocationParams&)> functionFn) {
            spdlog::info("Registering Native Function '{}'", functionName);
            _functions.try_emplace(functionName, functionFn);
        }

        FunctionInvocationResponse InvokeFunction(const std::string& functionName, FunctionInvocationParams& params) {
            if (HasFunction(functionName)) {
                auto fn = _functions[functionName];
                return fn(params);
            } else {
                return FunctionInvocationResponse::ReturnFunctionNotFound();
            }
        }
    };
}
