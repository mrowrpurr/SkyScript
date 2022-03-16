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
            AssertThat(functions.HasFunction("my::myFunction"), IsFalse());

            functions.RegisterFunction("my::myFunction", MyFunction);

            AssertThat(functions.Count(), Equals(1));
            AssertThat(functions.HasFunction("my::myFunction"), IsTrue());
        });
        it("can return text from a void parameterless function", [&](){
            auto& functions = NativeFunctions::GetSingleton();
            functions.RegisterFunction("my::myFunction", MyFunction);
            auto context = ContextImpl();
            auto scriptNode = Eval(context, R"(
- hello():
    :native: my::myFunction
)");
            auto& functionInfo = context.GetFunctionInfo("hello");
            auto params = FunctionInvocationParamsImpl(context, functionInfo, scriptNode);

            auto response = functions.InvokeFunction("my::myFunction", params);

            AssertThat(response.IsValue(), IsTrue());
            AssertThat(response.GetValueType(), Equals("string"));
            AssertThat(response.GetValue<std::string>(), Equals("Hi from function. No parameters provided."));
        });
        xit("can invoke void function with string parameter", [&](){
//            params.AddParameter("foo", TypedValueImpl("string", "This is the string"));
//            auto context = ContextImpl();
//
//            auto functionInfo = FunctionInfoImpl("myFunctions", "coolFunction");
//            // TODO ADD SOME PARAMETERS TO THIS FUNCTION INFO :) Use the FunctionInfo unit test (or make one)
//
//            auto params = FunctionInvocationParamsImpl(context, functionInfo);
//            auto& functions = NativeFunctions::GetSingleton();
//            functions.RegisterFunction("my::myFunction", MyFunction);
//
//            auto response = functions.InvokeFunction("my::myFunction", params);

//            AssertThat(response.IsValue(), IsTrue());
//            AssertThat(response.GetValueType(), Equals("string"));
//            AssertThat(response.GetValue<std::string>(), Equals("This is the text!"));
        });
        xit("can return primitive Text string from function", [&](){});
        xit("can return primitive Text string from function with string parameter", [&](){});
        xit("can invoke void function with ScriptNode parameter", [&](){});
        xit("stdlib::class function is available", [&](){});
        xit("stdlib::print function is available", [&](){});
    });
});
