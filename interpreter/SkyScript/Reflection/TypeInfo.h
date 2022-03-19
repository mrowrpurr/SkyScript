#pragma once

#include "InfoWithDocString.h"
#include "InfoWithNamespace.h"
#include "InfoWithMeta.h"

//#include "FieldInfo.h"
//#include "MemberInfo.h"
//#include "PropertyInfo.h"

namespace SkyScript::Reflection {

    class TypeInfo : public InfoWithDocString, public InfoWithNamespace, public InfoWithMeta {
    public:
//        virtual size_t FieldCount() = 0;
//        virtual size_t MethodCount() = 0;
//        virtual size_t PropertyCount() = 0;
//
//        size_t MemberCount() {
//            return FieldCount() + MethodCount() + PropertyCount();
//        }
    };
}
