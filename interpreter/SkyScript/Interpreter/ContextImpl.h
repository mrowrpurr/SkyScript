#pragma once

#include "SkyScript/Reflection/EvaluationError.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Interpreter/Reflection/FunctionInfoImpl.h"

using namespace SkyScript::Interpreter::Reflection;

namespace SkyScript::Interpreter {
    class ContextImpl : public SkyScript::Reflection::Context {
        // Function storage
        std::atomic<int> _functionIdCounter{};
        std::unordered_map<int64_t, FunctionInfoImpl> _functionsById;
        std::unordered_map<std::string, int64_t> _functionIdByName;
        std::unordered_map<std::string, int64_t> _functionIdByFullName;

        // Evaluation error
        bool _hasError = false;
        SkyScript::Reflection::EvaluationError _error;

    public:
        ContextImpl() = default;
        ContextImpl(const ContextImpl& context) {
            _functionIdCounter.exchange(context._functionIdCounter);
            _functionsById = context._functionsById;
            _functionIdByName = context._functionIdByName;
            _functionIdByFullName = context._functionIdByFullName;
            _hasError = context._hasError;
            _error = context._error;
        }

        size_t FunctionCount() override { return _functionsById.size(); }
        bool FunctionExists(const std::string& name) override { return _functionIdByName.contains(name) || _functionIdByFullName.contains(name); }

        bool HasError() override { return _hasError; }
        SkyScript::Reflection::EvaluationError GetError() override { return _error; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void AddFunction(FunctionInfoImpl info) {
            auto id = _functionIdCounter++;
            _functionsById.insert_or_assign(id, info);
            _functionIdByName.insert_or_assign(info.GetName(), id);
            _functionIdByFullName.insert_or_assign(info.GetFullName(), id);
        }

        void SetErrorMessage(const std::string& message) {
            _hasError = true;
            _error = {message};
        }
    };
}
