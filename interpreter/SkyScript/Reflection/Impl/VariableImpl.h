#pragma once

#include "SkyScript/Reflection/Variable.h"

namespace SkyScript::Reflection::Impl {

    class VariableImpl : public Variable {
        std::string _name;
        std::string _typeName;

    public:
        std::string GetName() override { return _name; }
        std::string GetTypeName() override { return _typeName; }
    };
}
