#pragma once

#include "TypedValue.h"

namespace SkyScript::Reflection {

    // TODO - Rename to VariableInfo
    class Variable {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetTypeName() = 0;
        virtual TypedValue& GetTypedValue() = 0;
    };
}
