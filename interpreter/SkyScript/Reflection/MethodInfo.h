#pragma once

#include "FunctionInfo.h"
#include "MemberInfo.h"

namespace SkyScript::Reflection {

    class MethodInfo : public MemberInfo, public FunctionInfo {

    };
}
