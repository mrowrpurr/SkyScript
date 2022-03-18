#pragma once

#include <utility>

#include "SkyScript/Reflection/TypeInfo.h"
#include "SkyScript/Reflection/Impl/FieldInfoImpl.h"
#include "SkyScript/Reflection/Impl/MethodInfoImpl.h"
#include "SkyScript/Reflection/Impl/PropertyInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class TypeInfoImpl : public TypeInfo {
        std::string _name;
        std::string _namespace;
        std::string _docString;
        std::unordered_map<std::string, FieldInfoImpl> _fields;
        std::unordered_map<std::string, MethodInfoImpl> _methods;
        std::unordered_map<std::string, PropertyInfoImpl> _properties;

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
        size_t FieldCount() override { return _fields.size(); }
        size_t MethodCount() override { return _methods.size(); }
        size_t PropertyCount() override { return _properties.size(); }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetDocString(const std::string& docString) { _docString = docString; }
        void AddField(const std::string& name, FieldInfoImpl fieldInfo) { _fields.insert_or_assign(name, fieldInfo); }
        void AddMethod(const std::string& name, MethodInfoImpl methodInfo) { _methods.insert_or_assign(name, methodInfo); }
        void AddProperty(const std::string& name, PropertyInfoImpl propertyInfo) { _properties.insert_or_assign(name, propertyInfo); }
    };
}
