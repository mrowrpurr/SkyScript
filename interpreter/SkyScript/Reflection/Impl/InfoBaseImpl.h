#pragma once

#include <utility>

#include "SkyScript/Reflection/InfoBase.h"

namespace SkyScript::Reflection {

    class InfoBaseImpl : public InfoBase {
        std::string _name;
        std::string _typeName;

    public:
        InfoBaseImpl() = default;
        explicit InfoBaseImpl(std::string name) : _name(std::move(name)) {}
        InfoBaseImpl(std::string name, std::string typeName) : _name(std::move(name)), _typeName(std::move(typeName)) {}

        std::string GetName() override { return _name; }
        std::string GetTypeName() override { return _typeName; }
    };
}
