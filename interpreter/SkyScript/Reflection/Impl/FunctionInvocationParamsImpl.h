#pragma once

#include <utility>

#include "SkyScript/Reflection/FunctionInvocationParams.h.h"

namespace SkyScript::Reflection::Impl {

    class FunctionInvocationParamsImpl : public FunctionInvocationParams {
        Context& _context;
        FunctionInfo& _functionInfo;
        SkyScriptNode& _expression;
        std::vector<TypedValueImpl> _parameters;
        std::unordered_map<std::string, size_t> _parameterIndicesByName;

    public:
        FunctionInvocationParamsImpl(Context& context, FunctionInfo& functionInfo, SkyScriptNode& expression)
        : _context(context), _functionInfo(functionInfo), _expression(expression) {}

        Context& GetContext() override { return _context; }
        FunctionInfo& GetFunctionInfo() override { return _functionInfo; }
        SkyScriptNode& GetExpression() override { return _expression; }

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
