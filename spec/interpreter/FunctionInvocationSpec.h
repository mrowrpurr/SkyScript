#pragma once

#include "specHelper.h"

#include <SkyScript/NativeFunctions.h>
#include <SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h>

using namespace SkyScript::Interpreter;
using namespace SkyScript::Reflection;

go_bandit([](){
    describe("Function invocation", [](){
        it("can invoke a void native function with no parameters", [&](){
            std::vector<std::string> responses{};
            AssertThat(responses.size(), Equals(0));

            auto nativeFunction = [&responses](FunctionInvocationParams&){
                responses.emplace_back("Hello!");
                return FunctionInvocationResponse::ReturnVoid();
            };
//
            NativeFunctions::GetSingleton().RegisterFunction("myFunctions::coolFunction", nativeFunction);
            auto context = ContextImpl();
            auto scriptNode = Eval(context, R"(
- myFunction():
    :native: myFunctions::coolFunction

- myFunction:
)");
            auto& functionInfo = context.GetFunctionInfo("myFunction");
            auto params = FunctionInvocationParamsImpl(context, functionInfo, scriptNode);

            NativeFunctions::GetSingleton().InvokeFunction("myFunctions::coolFunction", params);

            AssertThat(responses.size(), Equals(1));
            AssertThat(responses[0], Equals("Hello!"));
        });
        xit("can invoke a void native function with one string parameter", [&](){});
        xit("can invoke a void native function with string and int parameters", [&](){});
        xit("invoking native function causes runtime exception if native function not registered", [&](){});
        xit("invoking function with parameters not matching type signature causes runtime exception", [&](){});
        xit("function returning type not matching type signature causes runtime exception", [&](){});
    });
});
