#pragma once

#include "specHelper.h"

#include <SkyScript/NativeFunctions.h>
#include <SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h>

go_bandit([](){
    describe("Function invocation", [](){
        after_each([&](){
            NativeFunctions::GetSingleton().Clear();
        });
        it("can invoke a void native function with no parameters", [&](){
            std::vector<std::string> responses{};
            AssertThat(responses.size(), Equals(0));

            auto nativeFunction = [&responses](FunctionInvocationParams&){
                responses.emplace_back("Hello!");
                return FunctionInvocationResponse::ReturnVoid();
            };

            NativeFunctions::GetSingleton().RegisterFunction("myFunctions::coolFunction", nativeFunction);
            auto context = ContextImpl();
            auto scriptNode = Eval(context, R"(
- myFunction():
    :native: myFunctions::coolFunction

- myFunction:
)");

            AssertThat(responses.size(), Equals(1));
            AssertThat(responses[0], Equals("Hello!"));
        });
        it("can invoke a void native function with inline string parameter", [&](){
            std::vector<std::string> responses{};
            AssertThat(responses.size(), Equals(0));

            auto nativeFunction = [&responses](FunctionInvocationParams& params){
                responses.emplace_back(std::format("Received {} parameters", params.Count()));
                if (params.Any()) {
                    for (const auto& paramName : params.ParamNames()) {
                        responses.emplace_back(std::format("Param as string: {} = {}", paramName, params.Get<std::string>(paramName)));
                    }
                }
                return FunctionInvocationResponse::ReturnVoid();
            };

            NativeFunctions::GetSingleton().RegisterFunction("myFunctions::coolFunction", nativeFunction);
            auto context = ContextImpl();
            auto scriptNode = Eval(context, R"(
- myFunction():
    :native: myFunctions::coolFunction
    params:
    - greeting: string # TODO <--- type checking etc etc etc etc etc

- myFunction: hello world!
)");

            AssertThat(responses.size(), Equals(2));
            AssertThat(responses[0], Equals("Received 1 parameters"));
            AssertThat(responses[1], Equals("Param as string: greeting = hello world!"));
        });
        xit("can invoke a void native function with positional string parameter", [&](){});
        xit("can invoke a void native function with keyword string parameter", [&](){});
        xit("can invoke a void native function with full SkyScriptNode body", [&](){});

        //
        xit("can invoke a void native function with string and int parameters", [&](){});
        xit("invoking native function causes runtime exception if native function not registered", [&](){});
        xit("invoking function with parameters not matching type signature causes runtime exception", [&](){});
        xit("function returning type not matching type signature causes runtime exception", [&](){});
    });
});
