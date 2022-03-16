#pragma once

#include <utility>

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Impl/TypedValueImpl.h"

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

        void AddParameter(const std::string& name, const TypedValueImpl& value) {
            auto nextIndex = _parameters.size();
            _parameters.emplace_back(value);
            _parameterIndicesByName.try_emplace(name, nextIndex);
        }

        void AddStringParameter(const std::string& name, const std::string& value) {
            AddParameter(name, TypedValueImpl("stdlib::string", value));
        }

        void AddIntParameter(const std::string& name, int64_t value) {
            AddParameter(name, TypedValueImpl("stdlib::int", value));
        }

        void AddFloatParameter(const std::string& name, double value) {
            AddParameter(name, TypedValueImpl("stdlib::float", value));
        }

        void AddBoolParameter(const std::string& name, bool value) {
            AddParameter(name, TypedValueImpl("stdlib::bool", value));
        }

        void AddCustomTypeParameter(const std::string& name, const std::string& typeName, std::any value) {
            AddParameter(name, TypedValueImpl(typeName, value));
        }
    };
}
