#pragma once

#include <utility>

#include "SkyScript/Reflection/FieldInfo.h"
#include "SkyScript/Reflection/Impl/MemberInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class FieldInfoImpl : public FieldInfo, public MemberInfoImpl {
    public:
        FieldInfoImpl() = default;

        std::string GetName() override { return MemberInfoImpl::GetName(); }
        std::string GetDocString() override { return MemberInfoImpl::GetDocString(); }
        std::string GetTypeName() override { return MemberInfoImpl::GetTypeName(); }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

    };
}
