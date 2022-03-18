#pragma once

#include "FieldInfo.h"
#include "MemberInfo.h"
#include "PropertyInfo.h"

namespace SkyScript::Reflection {

    class TypeInfo {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetNamespace() = 0;
        virtual std::string GetFullName() = 0;
        virtual std::string GetDocString() = 0;
        virtual size_t FieldCount() = 0;
        virtual size_t MethodCount() = 0;
        virtual size_t PropertyCount() = 0;

        size_t MemberCount() {
            return FieldCount() + MethodCount() + PropertyCount();
        }
    };
}
