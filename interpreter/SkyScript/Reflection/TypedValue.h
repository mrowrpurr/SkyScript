#pragma once

#include <any>

namespace SkyScript::Reflection {

    class TypedValue {
    public:
        virtual std::string GetTypeName() = 0;
        virtual std::any GetValueAny() = 0;

        template <typename T>
        T GetValue() { return std::any_cast<T>(GetValueAny()); }

        std::string GetStringValue() { return GetValue<std::string>(); }
        int64_t GetIntValue() { return GetValue<int64_t>(); }
        double GetFloatValue() { return GetValue<double>(); }
        bool GetBoolValue() { return GetValue<bool>(); }
    };
}
