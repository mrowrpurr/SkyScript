#pragma once

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/GetType.h"
#include "SkyScript/Reflection/Type.h"
#include "SkyScript/Reflection/TypedValue.h"

namespace SkyScript::Reflection {

    class FunctionInvocationParams {
    public:
        virtual Context& GetContext() = 0;
        virtual FunctionInfo& GetFunctionInfo() = 0;
        virtual SkyScriptNode& GetExpression() = 0;
        virtual size_t GetParameterCount() = 0;
        virtual bool HasParameter(const std::string& name) = 0;
        virtual TypedValue& GetParameter(int index) = 0;
        virtual TypedValue& GetParameter(const std::string& name) = 0;
        virtual std::any& GetParameterValue(int index) = 0;
        virtual std::any& GetParameterValue(const std::string& name) = 0;
        virtual std::string GetParameterTypeName(int index) = 0;
        virtual std::string GetParameterTypeName(const std::string& name) = 0;

        // Helper functions / shortcuts:

        size_t Count() { return GetParameterCount(); }
        bool HasParam(const std::string& name) { return HasParameter(name); }
        TypedValue& Param(int index) { return GetParameter(index); }
        TypedValue& Param(const std::string& name) { return GetParameter(name); }
        std::string TypeName(int index) { return GetParameter(index).GetTypeName(); }
        std::string TypeName(const std::string& name) { return GetParameter(name).GetTypeName(); }
        std::optional<Reflection::Type&> Type(int index) { return GetType(GetParameter(index).GetTypeName()); }
        std::optional<Reflection::Type&> Type(const std::string& name) { return GetType(GetParameter(name).GetTypeName()); }
        Context& Context() { return GetContext(); }
        FunctionInfo& Function() { return GetFunctionInfo(); }
        SkyScriptNode& Expression() { return GetExpression(); }

        template <typename T>
        std::any& GetParameterAs(int index) { return std::any_cast<T>(GetParameterValue(index)); }

        template <typename T>
        std::any& GetParameterAs(const std::string& name) { return std::any_cast<T>(GetParameterValue(name)); }

        template <typename T>
        std::any& Get(int index) { return GetParameterAs<T>(index); }

        template <typename T>
        std::any& Get(const std::string& name) { return GetParameterAs<T>(name); }

        template <typename T>
        T operator [] (int index) { return GetParameterAs<T>(index); }

        template <typename T>
        T operator [] (const std::string& name) { return GetParameterAs<T>(name); }
    };
}
