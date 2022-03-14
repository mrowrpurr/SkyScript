#pragma once

#include <utility>

#include "SkyScript/Reflection/FunctionInfo.h"

namespace SkyScript::Interpreter::Reflection {
    class FunctionInfoImpl : public SkyScript::Reflection::FunctionInfo {
        std::string _namespace;
        std::string _name;

    public:
        FunctionInfoImpl(std::string functionNamespace, std::string functionName) :
            _namespace(std::move(functionNamespace)),
            _name(std::move(functionName)) {}
        FunctionInfoImpl(const FunctionInfoImpl& fn) {
            _namespace = fn._namespace;
            _name = fn._name;
        }

        std::string GetName() override { return _name; }
        std::string GetNamespace() override { return _namespace; }
        std::string GetFullName() override { return _namespace + "::" + _name; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////
    };
}