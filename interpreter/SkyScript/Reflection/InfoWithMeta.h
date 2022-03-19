#pragma once

#include <span>
#include <string>
#include <optional>

namespace SkyScript::Reflection {

    class InfoWithMeta {
    public:
        virtual std::span<std::string> GetMetaKeys() = 0;
        virtual bool HasMetaKey(const std::string& key) = 0;
        virtual bool HasMetaValue(const std::string& value) = 0;
        virtual std::optional<std::string> GetMetaValue(const std::string& key) = 0;
    };
}
