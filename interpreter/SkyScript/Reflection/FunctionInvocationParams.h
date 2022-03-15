#pragma once

#include "SkyScript/Reflection/FunctionInvocationParams.h"
#include "SkyScript/Reflection/Context.h"
#include "SkyScript/Reflection/FunctionInfo.h"

namespace SkyScript::Reflection {

    class FunctionInvocationParams {

    public:
        virtual Context& GetContext() = 0;
        virtual FunctionInfo& GetFunction() = 0;
    };
}
