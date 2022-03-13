#pragma once

#include "EvaluationError.h"

namespace SkyScript::Reflection {
    class Context {
    public:
        virtual size_t FunctionCount() = 0;
        virtual bool FunctionExists(const std::string& name) = 0;
        virtual bool HasError() = 0;
        virtual EvaluationError GetError() = 0;
    };
}