#pragma once

#include <spdlog/spdlog.h>

#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/Exceptions.h"
#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"
#include "SkyScript/Reflection/Impl/TypeImpl.h"
#include "SkyScript/Reflection/Impl/VariableImpl.h"

using namespace SkyScript::Reflection::Impl;

namespace SkyScript::Reflection::Impl {

    class ContextImpl : public SkyScript::Reflection::Context {
        // Function storage
        std::atomic<int> _functionIdCounter{};
        std::unordered_map<int64_t, FunctionInfoImpl> _functionsById;
        std::unordered_map<std::string, int64_t> _functionIdByName;
        std::unordered_map<std::string, int64_t> _functionIdByFullName;

        // Variable storage
        std::unordered_map<std::string, VariableImpl> _variables;

        // THEN TypesSpec with functions and fields (and properties later) (and constructors etc)

        // Types storage
        // TODO!!!! MAKE THIS BUT FOR TYPES :) for full name w/ namespace and simple name lookup :)
//        std::atomic<int> _functionIdCounter{};
//        std::unordered_map<int64_t, FunctionInfoImpl> _functionsById;
//        std::unordered_map<std::string, int64_t> _functionIdByName;
//        std::unordered_map<std::string, int64_t> _functionIdByFullName;

        // Evaluation error
        std::optional<SkyScript::Reflection::Exceptions::EvaluationError> _error;

    public:
        ContextImpl() = default;
        ContextImpl(const ContextImpl& context) {
            _functionIdCounter.exchange(context._functionIdCounter);
            _functionsById = context._functionsById;
            _functionIdByName = context._functionIdByName;
            _functionIdByFullName = context._functionIdByFullName;
            _error = context._error;
            _variables = context._variables;
        }

        size_t FunctionCount() override { return _functionsById.size(); }
        bool FunctionExists(const std::string& name) override { return _functionIdByName.contains(name) || _functionIdByFullName.contains(name); }

        size_t VariableCount() override { return _variables.size(); }
        bool VariableExists(const std::string& variableName) override { return _variables.contains(variableName); }

        size_t TypeCount() override { return 0; }
        bool TypeExists(const std::string&) override { return false; }

        bool HasError() override { return _error.has_value(); }
        std::optional<SkyScript::Reflection::Exceptions::EvaluationError> GetError() override { return _error; }

        SkyScript::Reflection::FunctionInfo& GetFunctionInfo(const std::string& functionName) override {
            if (_functionIdByFullName.contains(functionName)) {
                return _functionsById[_functionIdByFullName[functionName]];
            } else if (_functionIdByName.contains(functionName)) {
                return _functionsById[_functionIdByName[functionName]];
            } else {
                throw SkyScript::Reflection::Exceptions::FunctionNotFoundException(functionName);
            }
        }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetErrorMessage(const std::string& message) { _error = {message}; }

        void AddFunction(FunctionInfoImpl info) {
            spdlog::info("Declare function {}::{}()", info.GetNamespace(), info.GetName());

            auto id = _functionIdCounter++;
            _functionsById.insert_or_assign(id, info);
            _functionIdByName.insert_or_assign(info.GetName(), id);
            _functionIdByFullName.insert_or_assign(info.GetFullName(), id);
        }

        void AddVariable(VariableImpl var) {
            _variables.insert_or_assign(var.GetName(), var);
        }

//        void AddType(TypeImpl type) {
//            _types.insert_or_assign(type.GetName(), var);
//        }
    };
}
