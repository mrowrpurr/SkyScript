#pragma once

#include <string>

namespace SkyScript::Reflection {

    class InfoWithDocString {
    public:
        virtual std::string GetDocString() = 0;
    };
}
