#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/GetType.h"
#include "SkyScript/Reflection/Type.h"
#include "SkyScript/Reflection/TypedValue.h"

namespace SkyScript::Reflection {

    namespace {
        std::string TextForAny(const std::string& typeName, std::any value) {
            if (typeName == "stdlib::string" || typeName == "string") {
                return std::any_cast<std::string>(value);
            } else if (typeName == "stdlib::int" || typeName == "int") {
                return std::to_string(std::any_cast<int64_t>(value));
            } else if (typeName == "stdlib::float" || typeName == "float") {
                return std::to_string(std::any_cast<double>(value));
            } else if (typeName == "stdlib::bool" || typeName == "bool") {
                return std::to_string(std::any_cast<bool>(value));
            } else {
                spdlog::info("Custom types unsupported.");
                return std::format("CUSTOM TYPES UNSUPPORTED {}", typeName);
            }
        }
    }

    class FunctionInvocationParams {
    public:
        virtual Context& GetContext() = 0;
        virtual FunctionInfo& GetFunctionInfo() = 0;
        virtual SkyScriptNode& GetExpression() = 0;
        virtual size_t GetParameterCount() = 0;
        virtual bool HasParameter(const std::string& name) = 0;
        virtual TypedValue& GetParameter(int index) = 0;
        virtual TypedValue& GetParameter(const std::string& name) = 0;
        virtual std::vector<std::string> GetParameterNames() = 0;

        // Helper functions / shortcuts:

        size_t Count() { return GetParameterCount(); }
        bool HasParam(const std::string& name) { return HasParameter(name); }
        bool HasParameters() { return Count() > 0; }
        bool Any() { return Count() > 0; }
        std::vector<std::string> ParamNames() { return GetParameterNames(); }
        std::vector<std::string> Names() { return ParamNames(); }
        TypedValue& Param(int index) { return GetParameter(index); }
        TypedValue& Param(const std::string& name) { return GetParameter(name); }
        std::string TypeName(int index) { return GetParameter(index).GetTypeName(); }
        std::string TypeName(const std::string& name) { return GetParameter(name).GetTypeName(); }
        std::any GetParameterValue(int index) { return GetParameter(index).GetValueAny(); }
        std::any GetParameterValue(const std::string& name) { return GetParameter(name).GetValueAny(); }
        std::string GetParameterTypeName(int index) { return GetParameter(index).GetTypeName(); }
        std::string GetParameterTypeName(const std::string& name) { return GetParameter(name).GetTypeName(); }
        Context& Context() { return GetContext(); }
        FunctionInfo& Function() { return GetFunctionInfo(); }
        SkyScriptNode& Expression() { return GetExpression(); }
        std::string GetParameterValueText(int index) { return TextForAny(TypeName(index), GetParameterValue(index)); }
        std::string GetParameterValueText(const std::string& name) { return TextForAny(TypeName(name), GetParameterValue(name)); }
        std::string Text(const std::string& name) { return GetParameterValueText(name); }
        std::string GetText(const std::string& name) { return Text(name); }

        template <typename T>
        T GetParameterAs(int index) { return std::any_cast<T>(GetParameterValue(index)); }

        template <typename T>
        T GetParameterAs(const std::string& name) { return std::any_cast<T>(GetParameterValue(name)); }

        template <typename T>
        T Get(int index) { return GetParameterAs<T>(index); }

        template <typename T>
        T Get(const std::string& name) { return GetParameterAs<T>(name); }
    };
}
