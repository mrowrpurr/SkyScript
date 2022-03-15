#pragma once

#include "specHelper.h"

#include <SkyScript/Interpreter/NativeFunctions.h>
#include <SkyScript/Reflection/FunctionInvocationParams.h>
#include <SkyScript/Reflection/FunctionInvocationResponse.h>

using namespace SkyScript::Interpreter;
using namespace SkyScript::Reflection;

namespace {
    FunctionInvocationResponse MyFunction(FunctionInvocationParams&) { return {}; }
}

go_bandit([](){
    describe("Native Functions", []() {
        it("can register native functions", [&](){
            auto& functions = NativeFunctions::GetSingleton();
            AssertThat(functions.Count(), Equals(0));
            AssertThat(functions.HasFunction("my::myfunction"), IsFalse());

            functions.RegisterFunction("my::myfunction", MyFunction);

            AssertThat(functions.Count(), Equals(1));
            AssertThat(functions.HasFunction("my::myfunction"), IsTrue());
        });
        xit("can invoke void parameterless function", [&](){
            auto functionInfo = FunctionInfoImpl();

        });
//        xit("can invoke void function with string parameter", [&](){});
//        xit("can return primitive string from function", [&](){});
//        xit("can return primitive string from function with string parameter", [&](){});
//        xit("can invoke void function with ScriptNode parameter", [&](){});
//        xit("stdlib::class function is available", [&](){});
//        xit("stdlib::print function is available", [&](){});
    });
});
