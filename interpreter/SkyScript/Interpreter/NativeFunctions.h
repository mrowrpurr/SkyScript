#pragma once

namespace SkyScript::Interpreter {

    class NativeFunctions {

        NativeFunctions() = default;

    public:
        NativeFunctions(const NativeFunctions&) = delete;
        NativeFunctions &operator=(const NativeFunctions&) = delete;

        static NativeFunctions& GetSingleton() {
            static NativeFunctions nativeFunctions;
            return nativeFunctions;
        }
    };
}
