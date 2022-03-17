#pragma once

#include <utility>

#include "SkyScript/Reflection/Variable.h"
#include "SkyScript/Reflection/Impl/TypedValueImpl.h"

namespace SkyScript::Reflection::Impl {

    class VariableImpl : public Variable {
        std::string _name;
        std::string _typeName;
        TypedValueImpl _typedValue;

    public:
        VariableImpl() = default;
        VariableImpl(std::string name, std::string type) : _name(std::move(name)), _typeName(std::move(type)) {}
        VariableImpl(std::string name, std::string type, TypedValueImpl typeValue)
            : _name(std::move(name)), _typeName(std::move(type)), _typedValue(std::move(typeValue)) {}

        std::string GetName() override { return _name; }
        std::string GetTypeName() override { return _typeName; }
        TypedValue& GetTypedValue() override { return _typedValue; }
    };
}
