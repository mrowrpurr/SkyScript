#pragma once

#include <format>
#include <utility>

namespace SkyScript::Reflection::Exceptions {

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

    class SkyScriptNodeSingleMapNotFound : public std::exception {
    public:
        SkyScriptNodeSingleMapNotFound(const std::string& textRepresentationOfNode) :
                std::exception(std::format("SkyScript node is not a single map '{}'", textRepresentationOfNode).c_str()) {}
    };
}