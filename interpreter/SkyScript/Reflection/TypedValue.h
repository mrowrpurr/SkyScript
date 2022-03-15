#pragma once

namespace SkyScript::Reflection {

    class TypedValue {
    public:
        virtual std::string GetTypeName() = 0;
        virtual std::any GetValueAny() = 0;

        template <typename T>
        T GetValue() { return std::any_cast<T>(GetValueAny()); }
    };
}
