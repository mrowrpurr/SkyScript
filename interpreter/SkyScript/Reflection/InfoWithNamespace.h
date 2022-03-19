#pragma once

#include <string>

#include "InfoBase.h"

namespace SkyScript::Reflection {

    class InfoWithNamespace : public InfoBase {
    public:
        virtual std::string GetNamespace() = 0;
        virtual std::string GetFullName() = 0;
    };
}
