#pragma once

#include <utility>

#include "SkyScript/Reflection/VariableInfo.h"

#include "InfoBaseImpl.h"
#include "TypedValueImpl.h"

namespace SkyScript::Reflection::Impl {

    class VariableInfoImpl : public VariableInfo, public InfoBaseImpl {
        TypedValueImpl _typedValue;

    public:
        VariableInfoImpl() = default;
        VariableInfoImpl(std::string name, std::string typeName) : InfoBaseImpl(std::move(name), std::move(typeName)) {}
        VariableInfoImpl(std::string name, std::string typeName, TypedValueImpl typedValue)
            : InfoBaseImpl(std::move(name), std::move(typeName)), _typedValue(std::move(typedValue)) {}

        // Info Base
        std::string GetName() override { return InfoBaseImpl::GetName(); }
        std::string GetTypeName() override { return InfoBaseImpl::GetTypeName(); }

        // Variable Info
        TypedValue& GetTypedValue() override { return _typedValue; }
    };
}
