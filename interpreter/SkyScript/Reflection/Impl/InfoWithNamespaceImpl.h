#pragma once

#include "SkyScript/Reflection/InfoWithNamespace.h"

#include "InfoBaseImpl.h"

namespace SkyScript::Reflection {

    class InfoWithNamespaceImpl : public InfoWithNamespace, public InfoBaseImpl {
        std::string _namespace;

    public:
        std::string GetNamespace() override { return _namespace; }
        std::string GetFullName() override { return _namespace + "::" + InfoBaseImpl::GetName(); }
    };
}
