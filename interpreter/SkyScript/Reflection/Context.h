#pragma once

#include "Exceptions.h"
#include "FunctionInfo.h"

namespace SkyScript::Reflection {
    class Context {
    public:
        virtual bool HasError() = 0;
        virtual std::optional<Exceptions::EvaluationError> GetError() = 0;

        // See below for ideas for refactoring Variables + Functions APIs
        virtual size_t VariableCount() = 0;
        virtual bool VariableExists(const std::string& variableName) = 0;

        // TODO: make this more idiomatic by returning an iterator instead
        //       of having FunctionExists() and then GetFunctionInfo.
        //       For NOW, we'll just use an optional. But we'll switch it over!
        virtual FunctionInfo& GetFunctionInfo(const std::string& functionName) = 0;
        virtual size_t FunctionCount() = 0;
        virtual bool FunctionExists(const std::string& name) = 0;
    };
}