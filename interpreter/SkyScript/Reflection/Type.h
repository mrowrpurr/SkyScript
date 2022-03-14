#pragma once

namespace SkyScript::Reflection {

    class Type {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetNamespace() = 0;
    };
}
