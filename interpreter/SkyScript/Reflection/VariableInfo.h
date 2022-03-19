#pragma once

#include "InfoBase.h"
#include "TypedValue.h"

namespace SkyScript::Reflection {

    class VariableInfo : public InfoBase {
    public:
        virtual TypedValue& GetTypedValue() = 0;
    };
}
