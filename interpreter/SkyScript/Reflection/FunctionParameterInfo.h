#pragma once

#include "SkyScript/SkyScriptNode.h"

namespace SkyScript::Reflection {
    class FunctionParameterInfo {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetDocString() = 0;
        virtual std::string GetTypeName() = 0;
        virtual SkyScriptNode& GetDefaultValueExpression() = 0;
    };
}