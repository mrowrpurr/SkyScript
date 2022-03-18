#pragma once

#include <utility>

#include "SkyScript/Reflection/MemberInfo.h"

namespace SkyScript::Reflection::Impl {

    class MemberInfoImpl : public MemberInfo {
    protected:
        std::string _name;
        std::string _docString;
        std::string _typeName;

    public:
        std::string GetName() override { return _name; }
        std::string GetDocString() override { return _docString; }
        std::string GetTypeName() override { return _typeName; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

    };
}
