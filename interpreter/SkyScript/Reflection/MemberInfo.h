#pragma once

namespace SkyScript::Reflection {

    class MemberInfo {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetDocString() = 0;
        virtual std::string GetTypeName() = 0;
    };
}
