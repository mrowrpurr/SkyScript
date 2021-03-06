#pragma once

#include <format>
#include <utility>

namespace SkyScript::Reflection::Exceptions {

    // This isn't really an "exception" - reorganize / move this... TODO
    class EvaluationError {
        std::string _message;
    public:
        EvaluationError() = default;
        explicit EvaluationError(std::string message) : _message(std::move(message)) {}

        std::string GetMessage() { return _message; }
    };

    class FunctionNotFoundException : public std::exception {
    public:
        FunctionNotFoundException(std::string functionName) :
            std::exception(std::format("Function not found '{}'", functionName).c_str()) {}
    };

    class TypeNotFoundException : public std::exception {
    public:
        TypeNotFoundException(std::string typeName) :
                std::exception(std::format("Type not found '{}'", typeName).c_str()) {}
    };
}