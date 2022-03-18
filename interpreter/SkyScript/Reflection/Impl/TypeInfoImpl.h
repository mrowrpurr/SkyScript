#pragma once

#include <utility>

#include "SkyScript/Reflection/TypeInfo.h"

namespace SkyScript::Reflection::Impl {

    class TypeInfoImpl : public TypeInfo {
        std::string _name;
        std::string _namespace;
        std::string _docString;

    public:
        TypeInfoImpl() = default;
        TypeInfoImpl(std::string typeNamespace, std::string typeName) : _name(std::move(typeName)), _namespace(std::move(typeNamespace)) {}
        TypeInfoImpl(const TypeInfoImpl& type) {
            _name = type._name;
            _namespace = type._namespace;
            _docString = type._docString;
        }

        std::string GetName() override { return _name; }
        std::string GetNamespace() override { return _namespace; }
        std::string GetFullName() override { return _namespace + "::" + _name; }
        std::string GetDocString() override { return _docString; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetDocString(const std::string& docString) { _docString = docString; }
    };
}
