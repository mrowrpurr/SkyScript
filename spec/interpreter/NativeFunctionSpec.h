#pragma once

#include "specHelper.h"

#include <SkyScript/Interpreter/NativeFunctions.h>

using namespace SkyScript::Interpreter;

go_bandit([](){
    describe("Native Functions", []() {
        it("can register native functions", [&](){
            const auto& functions = NativeFunctions::GetSingleton();
            AssertThat(functions.Count(), Equals(0));

            // ...

            AssertThat(functions.Count(), Equals(1));
        });
        xit("can invoke void parameterless function", [&](){});
        xit("can invoke void function with string parameter", [&](){});
        xit("can return primitive string from function", [&](){});
        xit("can return primitive string from function with string parameter", [&](){});
        xit("stdlib::class function is available", [&](){});
        xit("stdlib::print function is available", [&](){});
    });
});
