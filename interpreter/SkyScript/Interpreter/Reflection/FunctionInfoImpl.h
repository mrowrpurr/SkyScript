#pragma once

#include <utility>

namespace SkyScript::Interpreter::Reflection {
    class FunctionInfoImpl {
        std::string _namespace;
        std::string _name;

    public:
        FunctionInfoImpl(std::string  functionNamespace, std::string functionName) :
            _namespace(std::move(functionNamespace)),
            _name(std::move(functionName)) {}
        FunctionInfoImpl(const FunctionInfoImpl& fn) {
            _namespace = fn._namespace;
            _name = fn._name;
        }

            std::string GetName() { return _name; }
        std::string GetNamespace() { return _namespace; }
        std::string GetFullName() { return _namespace + "::" + _name; }
    };
}