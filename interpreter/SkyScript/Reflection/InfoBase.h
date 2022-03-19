#pragma once

#include <string>

namespace SkyScript::Reflection {

    class InfoBase {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetTypeName() = 0;
    };
}
