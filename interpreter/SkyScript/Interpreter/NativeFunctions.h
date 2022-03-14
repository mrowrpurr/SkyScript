#pragma once

#include <atomic>

#include "SkyScript/Reflection/Impl/ContextImpl.h"

using namespace SkyScript::Reflection;

namespace SkyScript::Interpreter {

    class NativeFunctionParams {
        ContextImpl& _context;

    public:
        Context& GetContext() { return _context; }
    };

    enum NativeFunctionResponseType { NONE, EXCEPTION, TYPED_VALUE };

    // Error or Void or TypedValue
    class NativeFunctionResponse {
        NativeFunctionResponseType _type;

    public:
    };

    class NativeFunctions {
        std::unordered_map<std::string, std::function<NativeFunctionResponse(NativeFunctionParams&)>> _functions;

        NativeFunctions() = default;

    public:
        NativeFunctions(const NativeFunctions&) = delete;
        NativeFunctions &operator=(const NativeFunctions&) = delete;

        static NativeFunctions& GetSingleton() {
            static NativeFunctions nativeFunctions;
            return nativeFunctions;
        }

        size_t Count() { return _functions.size(); }

        void RegisterFunction(const std::string& functionName, std::function<NativeFunctionResponse(NativeFunctionParams&)> functionFn) {
            spdlog::info("Registering Native Function '{}'", functionName);
            _functions.try_emplace(functionName, functionFn);
        }
    };
}
