#pragma once

#include "SkyScript/Reflection/PropertyInfo.h"

namespace SkyScript::Reflection::Impl {
    class PropertyInfoImpl : public PropertyInfo, public MemberInfoImpl {
    public:
        // Info Base
        std::string GetName() override { return InfoBaseImpl::GetName(); }
        std::string GetTypeName() override { return InfoBaseImpl::GetTypeName(); }

        // With Doc String
        std::string GetDocString() override { return InfoWithDocStringImpl::GetDocString(); }

        // With Meta
        std::span<std::string> GetMetaKeys() override { return InfoWithMetaImpl::GetMetaKeys(); }
        bool HasMetaKey(const std::string& key) override { return InfoWithMetaImpl::HasMetaKey(key); }
        bool HasMetaValue(const std::string& key) override { return InfoWithMetaImpl::HasMetaValue(key); };
        std::optional<std::string> GetMetaValue(const std::string& key) override { return InfoWithMetaImpl::GetMetaValue(key); }
    };
}
