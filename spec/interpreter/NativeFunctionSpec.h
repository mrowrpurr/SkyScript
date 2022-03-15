#pragma once

#include "specHelper.h"

#include <SkyScript/Interpreter/NativeFunctions.h>
#include <SkyScript/Reflection/FunctionInvocationResponse.h>
#include <SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h>

using namespace SkyScript::Interpreter;
using namespace SkyScript::Reflection;

namespace {
    FunctionInvocationResponse MyFunction(FunctionInvocationParams&) {
        return FunctionInvocationResponse::ReturnValue<std::string>("string", "This is the text!");
    }
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
        it("can invoke void parameterless function", [&](){
            auto context = ContextImpl();
            auto functionInfo = FunctionInfoImpl("myFunctions", "coolFunction");
            auto params = FunctionInvocationParamsImpl(context, functionInfo);
            auto& functions = NativeFunctions::GetSingleton();
            functions.RegisterFunction("my::myfunction", MyFunction);

            auto response = functions.InvokeFunction("my::myfunction", params);

            AssertThat(response.IsValue(), IsTrue());
            AssertThat(response.GetValueType(), Equals("string"));
            AssertThat(response.GetValue<std::string>(), Equals("This is the text!"));
        });
//        xit("can invoke void function with string parameter", [&](){});
//        xit("can return primitive string from function", [&](){});
//        xit("can return primitive string from function with string parameter", [&](){});
//        xit("can invoke void function with ScriptNode parameter", [&](){});
//        xit("stdlib::class function is available", [&](){});
//        xit("stdlib::print function is available", [&](){});
    });
});
