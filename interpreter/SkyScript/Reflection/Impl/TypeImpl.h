#pragma once

#include <utility>

#include "SkyScript/Reflection/Type.h"

namespace SkyScript::Reflection::Impl {

    class TypeImpl : public Type {
        std::string _name;
        std::string _namespace;

    public:
        TypeImpl(std::string typeNamespace, std::string typeName) : _name(std::move(typeName)), _namespace(std::move(typeNamespace)) {}
        std::string GetName() override { return _name; }
        std::string GetNamespace() override { return _namespace; }
    };
}
