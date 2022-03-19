#pragma once

#include "SkyScript/Reflection/InfoWithDocString.h"

namespace SkyScript::Reflection {

    class InfoWithDocStringImpl : public InfoWithDocString {
        std::string _docString;

    public:
        std::string GetDocString() override { return _docString; }
    };
}
