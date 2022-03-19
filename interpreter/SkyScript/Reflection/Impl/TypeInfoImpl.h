#pragma once

#include <utility>

#include "SkyScript/Reflection/TypeInfo.h"

#include "InfoBaseImpl.h"
#include "InfoWithDocStringImpl.h"
#include "InfoWithNamespaceImpl.h"
#include "InfoWithMetaImpl.h"
#include "FieldInfoImpl.h"
#include "MethodInfoImpl.h"
#include "PropertyInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class TypeInfoImpl : public TypeInfo, public InfoWithDocStringImpl, public InfoWithNamespaceImpl, public InfoWithMetaImpl {
        std::unordered_map<std::string, FieldInfoImpl> _fields;
        std::unordered_map<std::string, MethodInfoImpl> _methods;
        std::unordered_map<std::string, PropertyInfoImpl> _properties;

    public:
//        TypeInfoImpl() = default;
//        TypeInfoImpl(std::string typeNamespace, std::string typeName) : _name(std::move(typeName)), _namespace(std::move(typeNamespace)) {}
//        TypeInfoImpl(const TypeInfoImpl& type) {
//            _name = type._name;
//            _namespace = type._namespace;
//            _docString = type._docString;
//        }

        // With Namespace
        std::string GetNamespace() override { return InfoWithNamespaceImpl::GetNamespace(); }
        std::string GetFullName() override { return InfoWithNamespaceImpl::GetFullName(); }

        // Info Base
        std::string GetName() override { return InfoBaseImpl::GetName(); }
        std::string GetTypeName() override { return InfoBaseImpl::GetTypeName(); }

        // With Doc String
        std::string GetDocString() override { return InfoWithDocStringImpl::GetDocString(); }

        // With Meta
        std::span<std::string> GetMetaKeys() override { return InfoWithMetaImpl::GetMetaKeys(); }
        bool HasMetaKey(const std::string& key) override { return InfoWithMetaImpl::HasMetaKey(key); }
        bool HasMetaValue(const std::string& key) override { return InfoWithMetaImpl::HasMetaValue(key); };
        std::optional<std::string> GetMetaValue(const std::string& key) override { return InfoWithMetaImpl::GetMetaValue(key); }

//        size_t FieldCount() override { return _fields.size(); }
//        size_t MethodCount() override { return _methods.size(); }
//        size_t PropertyCount() override { return _properties.size(); }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

//        void SetDocString(const std::string& docString) { _docString = docString; }
//        void AddField(const std::string& name, FieldInfoImpl fieldInfo) { _fields.insert_or_assign(name, fieldInfo); }
//        void AddMethod(const std::string& name, MethodInfoImpl methodInfo) { _methods.insert_or_assign(name, methodInfo); }
//        void AddProperty(const std::string& name, PropertyInfoImpl propertyInfo) { _properties.insert_or_assign(name, propertyInfo); }
    };
}
