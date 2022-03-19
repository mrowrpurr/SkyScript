#pragma once

#include <utility>

#include "SkyScript/Reflection/MemberInfo.h"

#include "InfoBaseImpl.h"
#include "InfoWithDocStringImpl.h"
#include "InfoWithMetaImpl.h"

namespace SkyScript::Reflection::Impl {
    class MemberInfoImpl : public MemberInfo, public InfoBaseImpl, public InfoWithDocStringImpl, public InfoWithMetaImpl {};
}
