#pragma once

#include <utility>

#include "SkyScript/Reflection/Impl/TypedValueImpl.h"

using namespace SkyScript::Reflection::Impl;

namespace SkyScript::Reflection {

    class FunctionInvocationResponseError {
        std::string _message;
    public:
        explicit FunctionInvocationResponseError(std::string message) : _message(std::move(message)) {}
        std::string GetMessage() { return _message; }
    };

    class FunctionInvocationResponse {
        enum Type { Void, Error, Value, FunctionNotFound };
        Type _type = Type::Void;
        std::optional<TypedValueImpl> _typedValue;

    public:
        FunctionInvocationResponse() = default;

        static FunctionInvocationResponse ReturnVoid() {
            return *FunctionInvocationResponse().SetVoid();
        }

        static FunctionInvocationResponse ReturnFunctionNotFound() {
            return *FunctionInvocationResponse().SetFunctionNotFound();
        }

        template <typename T>
        static FunctionInvocationResponse ReturnValue(const std::string& typeName, T value) {
            return *FunctionInvocationResponse().SetValue(typeName, value);
        }

        template <typename T>
        static FunctionInvocationResponse ReturnError(const std::string& typeName, T value) {
            return *FunctionInvocationResponse().SetError(typeName, value);
        }
        static FunctionInvocationResponse ReturnError(const std::string& message) {
            return *FunctionInvocationResponse().SetError(message);
        }

        bool IsVoid() { return _type == Type::Void; }
        FunctionInvocationResponse* SetVoid() {
            _type = Type::Void;
            return this;
        }

        bool IsValue() { return _type == Type::Value; }
        template <typename T>
        FunctionInvocationResponse* SetValue(const std::string& typeName, T value) {
            _typedValue = TypedValueImpl(typeName, std::make_any<T>(value));
            _type = Type::Value;
            return this;
        }
        template <typename T>
        T GetValue() { return _typedValue.value().GetValue<T>(); }
        std::string GetValueType() { return _typedValue.value().GetTypeName(); }

        bool IsError() { return _type == Type::Error; }
        template <typename T>
        FunctionInvocationResponse* SetError(const std::string& typeName, T value) {
            _typedValue = TypedValueImpl(typeName, std::make_any<T>(value));
            _type = Type::Error;
            return this;
        }
        FunctionInvocationResponse* SetError(const std::string& message) {
            return SetError("FunctionInvocationError", FunctionInvocationResponseError(message));
        }

        bool IsNotFound() { return _type == Type::FunctionNotFound; }
        FunctionInvocationResponse* SetFunctionNotFound() {
            _type = Type::FunctionNotFound;
            return this;
        }
    };
}
