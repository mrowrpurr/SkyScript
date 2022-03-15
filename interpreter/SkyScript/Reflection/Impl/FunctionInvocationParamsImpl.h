#pragma once

#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"

namespace SkyScript::Reflection {

    class FunctionInvocationParamsImpl : public FunctionInvocationParams {
        ContextImpl& _context;
        FunctionInfoImpl& _function;

    public:
        Context& GetContext() { return _context; }
        FunctionInfo& GetFunction() { return _function; }
    };
}
