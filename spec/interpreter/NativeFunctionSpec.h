#pragma once

#include "specHelper.h"

#include <SkyScript/Interpreter/NativeFunctions.h>
#include <SkyScript/Reflection/FunctionInvocationResponse.h>
#include <SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h>

using namespace SkyScript::Interpreter;
using namespace SkyScript::Reflection;

namespace {
    FunctionInvocationResponse MyFunction(FunctionInvocationParams& params) {
        if (params.Any()) {
             std::string response{"Provided parameters:"};
             for (const auto& paramName : params.ParamNames()) {
                 response += std::format(" {}:{}:", paramName, params.GetParameterTypeName(paramName));
                 auto typeName = params.TypeName(paramName);
                 if (typeName == "string") {
                     response += params.Get<std::string>(paramName);
                 } else if (typeName == "int") {
                     response += std::to_string(params.Get<int64_t>(paramName));
                 }
             }
            return FunctionInvocationResponse::ReturnValue<std::string>("string", response);
        } else {
            return FunctionInvocationResponse::ReturnValue<std::string>("string", "Hi from function. No parameters provided.");
        }
    }
}

go_bandit([](){
    describe("Native Functions", []() {
        after_each([&](){
            NativeFunctions::GetSingleton().Clear();
        });
        it("can register native functions", [&](){
            auto& functions = NativeFunctions::GetSingleton();
            AssertThat(functions.Count(), Equals(0));
            AssertThat(functions.HasFunction("my::myFunction"), IsFalse());

            functions.RegisterFunction("my::myFunction", MyFunction);

            AssertThat(functions.Count(), Equals(1));
            AssertThat(functions.HasFunction("my::myFunction"), IsTrue());
        });
        it("can return text from a function", [&](){
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
        it("allows native functions to read provided parameters", [&](){
            auto& functions = NativeFunctions::GetSingleton();
            functions.RegisterFunction("my::myFunction", MyFunction);
            auto context = ContextImpl();
            auto scriptNode = Eval(context, R"(
- hello():
    :native: my::myFunction
)");
            auto& functionInfo = context.GetFunctionInfo("hello");
            auto params = FunctionInvocationParamsImpl(context, functionInfo, scriptNode);

            // Provide 2 parameters:
            // foo: string
            // bar: int
            std::string foo{"This is foo!"};
            int64_t bar{69};
            params.AddParameter("foo", TypedValueImpl("string", foo));
            params.AddParameter("bar", TypedValueImpl("int", bar));

            auto response = functions.InvokeFunction("my::myFunction", params);

            AssertThat(response.IsValue(), IsTrue());
            AssertThat(response.GetValueType(), Equals("string"));
            AssertThat(response.GetValue<std::string>(), Equals("Provided parameters: foo:string:This is foo! bar:int:69"));
        });
//        xit("can return primitive Text string from function", [&](){});
//        xit("can return primitive Text string from function with string parameter", [&](){});
//        xit("can invoke void function with ScriptNode parameter", [&](){});
//        xit("stdlib::class function is available", [&](){});
//        xit("stdlib::print function is available", [&](){});
    });
});
