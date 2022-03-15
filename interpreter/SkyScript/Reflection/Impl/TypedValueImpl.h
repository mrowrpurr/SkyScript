#pragma once

#include <any>
#include <utility>

#include "SkyScript/Reflection/TypedValue.h"

namespace SkyScript::Reflection::Impl {

    class TypedValueImpl : public TypedValue {
        std::string _typeName;
        std::any _value;

    public:
        TypedValueImpl() = default;
        explicit TypedValueImpl(std::string typeName) : _typeName(std::move(typeName)) {}
        TypedValueImpl(std::string typeName, std::any value) : _typeName(std::move(typeName)), _value(std::move(value)) {}

        std::string GetTypeName() override { return _typeName; }
        std::any GetValueAny() override { return _value; }

        template <typename T>
        void SetValue(T value) { _value = value; }
        void SetValue(std::any value) { _value = std::move(value); }
    };
}
