#pragma once

#include "specHelper.h"

#include <SkyScript/Interpreter/NativeFunctions.h>

using namespace SkyScript::Interpreter;

namespace {
    NativeFunctionResponse MyFunction(NativeFunctionParams&) { return {}; }
}

go_bandit([](){
    describe("Native Functions", []() {
        it("can register native functions", [&](){
            auto& functions = NativeFunctions::GetSingleton();
            AssertThat(functions.Count(), Equals(0));

            functions.RegisterFunction("my::myfunction", MyFunction);

            AssertThat(functions.Count(), Equals(1));
        });

        // Call it. Read params from the params object. Let it be pretty dynamic! Reusable functions :)

//        xit("can invoke void parameterless function", [&](){});
//        xit("can invoke void function with string parameter", [&](){});
//        xit("can return primitive string from function", [&](){});
//        xit("can return primitive string from function with string parameter", [&](){});
//        xit("can invoke void function with ScriptNode parameter", [&](){});
//        xit("stdlib::class function is available", [&](){});
//        xit("stdlib::print function is available", [&](){});
    });
});
