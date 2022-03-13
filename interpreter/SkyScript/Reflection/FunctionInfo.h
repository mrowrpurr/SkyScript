#pragma once

namespace SkyScript::Reflection {
    class FunctionInfo {
    public:
        virtual std::string GetName() = 0;
        virtual std::string GetNamespace() = 0;
        virtual std::string GetFullName() = 0;
    };
}