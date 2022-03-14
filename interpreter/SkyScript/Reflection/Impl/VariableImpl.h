#pragma once

#include <utility>

#include "SkyScript/Reflection/Variable.h"

namespace SkyScript::Reflection::Impl {

    class VariableImpl : public Variable {
        std::string _name;
        std::string _typeName;

    public:
        VariableImpl(std::string name, std::string type) : _name(std::move(name)), _typeName(std::move(type)) {}
        std::string GetName() override { return _name; }
        std::string GetTypeName() override { return _typeName; }
    };
}
