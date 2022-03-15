#pragma once

#include "SkyScript/Reflection/FunctionParameterInfo.h"

namespace SkyScript::Reflection {
    class FunctionInfo {
    public:
        class FunctionParameterNotFound : public std::logic_error {
        public:
            FunctionParameterNotFound(const std::string& functionName, size_t index)
                : std::logic_error(std::format("No parameter of {} found by index {}", functionName, index)) {}
            FunctionParameterNotFound(const std::string& functionName, const std::string& name)
                : std::logic_error(std::format("No parameter of {} found by name '{}'", functionName, name)) {}
        };
        virtual std::string GetName() = 0;
        virtual std::string GetNamespace() = 0;
        virtual std::string GetFullName() = 0;
        virtual std::string GetDocString() = 0;
        virtual bool IsNative() = 0;
        virtual size_t GetParameterCount() = 0;
        virtual std::vector<std::string>& GetParameterNames() = 0;
        virtual FunctionParameterInfo& GetParameter(int index) = 0;
        virtual FunctionParameterInfo& GetParameter(const std::string& name) = 0;
        virtual bool HasParameterName(const std::string& name) = 0;
    };
}