#pragma once

#include <utility>

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/FunctionInvocationParams.h"

namespace SkyScript::Reflection::Impl {

    class FunctionInvocationParamsImpl : public FunctionInvocationParams {
        Reflection::Context& _context;
        FunctionInfo& _functionInfo;
        SkyScriptNode& _expression;
        std::vector<TypedValueImpl> _parameters;
        std::unordered_map<std::string, size_t> _parameterIndicesByName;

    public:
        FunctionInvocationParamsImpl(Reflection::Context& context, FunctionInfo& functionInfo, SkyScriptNode& expression)
        : _context(context), _functionInfo(functionInfo), _expression(expression) {}

        Reflection::Context& GetContext() override { return _context; }
        FunctionInfo& GetFunctionInfo() override { return _functionInfo; }
        SkyScriptNode& GetExpression() override { return _expression; }
        size_t GetParameterCount() override { return _parameters.size(); }
        bool HasParameter(const std::string& name) override { return _parameterIndicesByName.contains(name); }
        TypedValue& GetParameter(int index) override { return _parameters[index]; }
        TypedValue& GetParameter(const std::string& name) override { return _parameters[_parameterIndicesByName[name]]; }
        std::vector<std::string> GetParameterNames() override {
            std::vector<std::string> paramNames;
            for (const auto& [key, value] : _parameterIndicesByName) {
                paramNames.emplace_back(key);
            }
            return paramNames;
        }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void AddParameter(const std::string& name, TypedValueImpl value) {
            auto nextIndex = _parameters.size();
            _parameters.emplace_back(value);
            _parameterIndicesByName.try_emplace(name, nextIndex);
        }
    };
}
