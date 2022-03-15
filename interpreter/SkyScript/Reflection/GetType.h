#pragma once

#include "SkyScript/Reflection/Impl/TypeImpl.h"

namespace SkyScript::Reflection {

    std::optional<Type&> GetType(const std::string&) {
        return Impl::TypeImpl();
    }
}
