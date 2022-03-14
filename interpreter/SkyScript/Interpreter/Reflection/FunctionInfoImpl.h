#pragma once

#include <utility>

#include "SkyScript/Reflection/FunctionInfo.h"

namespace SkyScript::Interpreter::Reflection {
    class FunctionInfoImpl : public SkyScript::Reflection::FunctionInfo {
        std::string _namespace;
        std::string _name;
        std::string _docString;
        bool _isNative;

    public:
        FunctionInfoImpl() = default;
        FunctionInfoImpl(std::string functionNamespace, std::string functionName) :
            _namespace(std::move(functionNamespace)),
            _name(std::move(functionName)) {}
        FunctionInfoImpl(const FunctionInfoImpl& fn) {
            _namespace = fn._namespace;
            _name = fn._name;
            _docString = fn._docString;
            _isNative = fn._isNative;
        }

        std::string GetName() override { return _name; }
        std::string GetNamespace() override { return _namespace; }
        std::string GetFullName() override { return _namespace + "::" + _name; }
        std::string GetDocString() override { return _docString; }
        bool IsNative() override { return _isNative; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetDocString(const std::string& docString) { _docString = docString; }
        void SetIsNative(bool isNative) { _isNative = isNative; }
    };
}