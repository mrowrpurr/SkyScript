#pragma once

namespace SkyScript::Reflection {

    enum FunctionInvocationResponseType { Void, Error, Value };

    class FunctionInvocationResponse {
        FunctionInvocationResponseType _type;

    public:
        FunctionInvocationResponseType GetType() { return _type; }
    };
}
