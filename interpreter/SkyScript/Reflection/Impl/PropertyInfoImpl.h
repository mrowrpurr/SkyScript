#pragma once

#include <utility>

#include "SkyScript/Reflection/PropertyInfo.h"
#include "SkyScript/Reflection/Impl/MemberInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class PropertyInfoImpl : public PropertyInfo, public MemberInfoImpl {
    public:
        PropertyInfoImpl() = default;

        std::string GetName() override { return MemberInfoImpl::GetName(); }
        std::string GetDocString() override { return MemberInfoImpl::GetDocString(); }
        std::string GetTypeName() override { return MemberInfoImpl::GetTypeName(); }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

    };
}
