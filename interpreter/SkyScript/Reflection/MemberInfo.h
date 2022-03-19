#pragma once

#include "InfoBase.h"
#include "InfoWithDocString.h"
#include "InfoWithMeta.h"

namespace SkyScript::Reflection {
    class MemberInfo : InfoBase, InfoWithDocString, InfoWithMeta {};
}
