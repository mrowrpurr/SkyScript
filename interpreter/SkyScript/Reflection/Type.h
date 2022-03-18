#pragma once

namespace SkyScript::Reflection {

    // TODO - rename to TypeInfo
    class Type {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetNamespace() = 0;
        virtual std::string GetFullName() = 0;
    };
}
