#pragma once

namespace SkyScript::Reflection {
    class Context {
    public:
        virtual size_t FunctionCount() = 0;
        virtual bool FunctionExists(const std::string& name) = 0;
    };
}