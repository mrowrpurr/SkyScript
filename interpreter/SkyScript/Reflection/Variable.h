#pragma once

namespace SkyScript::Reflection {

    class Variable {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetTypeName() = 0;
    };
}
