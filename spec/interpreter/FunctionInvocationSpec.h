#pragma once

#include "specHelper.h"

#include <SkyScript/NativeFunctions.h>
#include <SkyScript/Reflection/FunctionInvocationParams.h>
#include <SkyScript/Reflection/Impl/FunctionInvocationParamsImpl.h>

using namespace SkyScript::Reflection;

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
        it("can invoke a void native function with positional string parameter", [&](){
            std::vector<std::string> responses{};
            AssertThat(responses.size(), Equals(0));

            auto nativeFunction = [&responses](FunctionInvocationParams& params){
                responses.emplace_back(std::format("Received {} parameters", params.Count()));
                if (params.Any()) {
                    for (const auto& paramName : params.ParamNames()) {
                        responses.emplace_back(std::format("Param {} {} = {}", params.TypeName(paramName), paramName, params.Text(paramName)));
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
    - greeting: string
    - number: int

- myFunction:
  - hello
  - 69
)");

            AssertThat(responses.size(), Equals(3));
            AssertThat(responses[0], Equals("Received 2 parameters"));
            AssertThat(responses[1], Equals("Param stdlib::string greeting = hello"));
            AssertThat(responses[2], Equals("Param stdlib::int number = 69"));
        });
        it("can invoke a void native function with keyword string parameter", [&](){
            std::vector<std::string> responses{};
            AssertThat(responses.size(), Equals(0));

            auto nativeFunction = [&responses](FunctionInvocationParams& params){
                responses.emplace_back(std::format("Received {} parameters", params.Count()));
                if (params.Any()) {
                    for (const auto& paramName : params.ParamNames()) {
                        responses.emplace_back(std::format("Param {} {} = {}", params.TypeName(paramName), paramName, params.Text(paramName)));
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
    - greeting: string
    - number: int

- myFunction:
    greeting: what's up?
    number: 420
)");

//            AssertThat(responses.size(), Equals(3));
            AssertThat(responses[0], Equals("Received 2 parameters"));
            AssertThat(responses[1], Equals("Param stdlib::string greeting = what's up?"));
            AssertThat(responses[2], Equals("Param stdlib::int number = 420"));
        });

        // Might move these into an ExpressionsSpec or something:
        it("can pass a string variable to a function", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
                for (const auto& paramName : params.ParamNames()) {
                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- gimmeVariableFn():
    :native: gimmeVariableFn
    params:
    - param: string

- someVariable =: hello!

- gimmeVariableFn: $someVariable
- gimmeVariableFn: \$someVariable
- gimmeVariableFn: \\$someVariable
)");
            AssertThat(receivedVariables.size(), Equals(3));
            AssertThat(receivedVariables[0], Equals("Received parameter param of type stdlib::string and value 'hello!'"));
            AssertThat(receivedVariables[1], Equals("Received parameter param of type stdlib::string and value '$someVariable'"));
            AssertThat(receivedVariables[2], Equals("Received parameter param of type stdlib::string and value '\\$someVariable'"));
        });
        it("can pass a int variable to a function", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
                for (const auto& paramName : params.ParamNames()) {
                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- gimmeVariableFn():
    :native: gimmeVariableFn
    params:
    - param: string

- someNumber =: 69

- gimmeVariableFn: $someNumber
)");
            AssertThat(receivedVariables.size(), Equals(1));
            AssertThat(receivedVariables[0], Equals("Received parameter param of type stdlib::int and value '69'"));
        });
        it("can pass a float variable to a function", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
                for (const auto& paramName : params.ParamNames()) {
                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- gimmeVariableFn():
    :native: gimmeVariableFn
    params:
    - param: string

- someNumber =: 69.420

- gimmeVariableFn: $someNumber
)");
            AssertThat(receivedVariables.size(), Equals(1));
            AssertThat(receivedVariables[0], Contains("Received parameter param of type stdlib::float and value '69.420"));
        });
        it("can pass a bool variable to a function", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
                for (const auto& paramName : params.ParamNames()) {
                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- gimmeVariableFn():
    :native: gimmeVariableFn
    params:
    - param: string

- thisIsTrue =: true
- thisIsFalse =: false

- gimmeVariableFn: $thisIsTrue
- gimmeVariableFn: $thisIsFalse
)");
            AssertThat(receivedVariables.size(), Equals(2));
            AssertThat(receivedVariables[0], Equals("Received parameter param of type stdlib::bool and value 'true'"));
            AssertThat(receivedVariables[1], Equals("Received parameter param of type stdlib::bool and value 'false'"));
        });
        it("can escape dollar variables", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
                for (const auto& paramName : params.ParamNames()) {
                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- gimmeVariableFn():
    :native: gimmeVariableFn
    params:
    - param: string

- $someVariable =: hello from double dollar

- gimmeVariableFn: $$someVariable
)");
            AssertThat(receivedVariables.size(), Equals(1));
            AssertThat(receivedVariables[0], Equals("Received parameter param of type stdlib::string and value 'hello from double dollar'"));
        });

        // Required for class() function:
        it("can invoke a void native function with full SkyScriptNode body", [&](){
            std::vector<std::string> receivedVariables;
            auto context = ContextImpl();
            NativeFunctions::GetSingleton().RegisterFunction("passCustomParams", [&receivedVariables](FunctionInvocationParams& params){
                auto& rightHandSide = params.Expression().GetSingleValue();
                if (rightHandSide.IsValue()) {
                    receivedVariables.emplace_back(std::format("Passed value '{}'", rightHandSide.GetStringValue()));
                } else if (rightHandSide.IsArray()) {
                    receivedVariables.emplace_back(std::format("Passed array '{}'", rightHandSide.toString()));
                } else if (rightHandSide.IsMap()) {
                    receivedVariables.emplace_back(std::format("Passed map '{}'", rightHandSide.toString()));
                }
                return FunctionInvocationResponse::ReturnVoid();
            });

            Eval(context, R"(
- passCustomParams():
    :native: passCustomParams
    :custom_params:

- passCustomParams: inline value
- passCustomParams:
  - array
  - of
  - values
- passCustomParams:
    some key: some value
    another key: another value
)");
            AssertThat(receivedVariables[0], Equals("Passed value 'inline value'"));
            AssertThat(receivedVariables[1], Equals("Passed array '- array\n- of\n- values\n'"));
            AssertThat(receivedVariables[2], Equals("Passed map 'some key: some value\nanother key: another value\n'"));
            AssertThat(receivedVariables.size(), Equals(3));
        });

        //
        xit("can invoke a void native function with string and int parameters", [&](){});
        xit("invoking native function causes runtime exception if native function not registered", [&](){});
        xit("invoking function with parameters not matching type signature causes runtime exception", [&](){});
        xit("function returning type not matching type signature causes runtime exception", [&](){});
    });
});
