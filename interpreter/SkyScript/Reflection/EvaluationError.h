#pragma once

#include <utility>

namespace SkyScript::Reflection {
    class EvaluationError {
        std::string _message;

    public:
        EvaluationError() = default;
        EvaluationError(std::string  message) : _message(std::move(message)) {}

        std::string GetMessage() { return _message; }
    };
}