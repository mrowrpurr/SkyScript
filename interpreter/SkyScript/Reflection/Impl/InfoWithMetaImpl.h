#pragma once

#include <unordered_map>

#include "SkyScript/Reflection/InfoWithMeta.h"

namespace SkyScript::Reflection {

    class InfoWithMetaImpl : public InfoWithMeta {
        std::unordered_map<std::string, std::string> _meta;

    public:
        InfoWithMetaImpl() = default;

        std::span<std::string> GetMetaKeys() override {
            // TODO
            return {};
        }
        bool HasMetaKey(const std::string& key) override { return _meta.contains(key); }
        bool HasMetaValue(const std::string& key) override { return _meta.contains(key) && ! _meta[key].empty(); };
        std::optional<std::string> GetMetaValue(const std::string& key) override {
            if (_meta.contains(key)) {
                return _meta[key];
            } else {
                return {};
            }
        }
    };
}
