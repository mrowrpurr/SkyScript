#pragma once

#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Impl/ContextImpl.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class FunctionInvocationParamsImpl : public FunctionInvocationParams {
        ContextImpl& _context;
        FunctionInfoImpl& _function;

    public:
        FunctionInvocationParamsImpl(ContextImpl& context, FunctionInfoImpl& function) : _context(context), _function(function) {};

        Context& GetContext() override { return _context; }
        FunctionInfo& GetFunction() override { return _function; }
    };
}
