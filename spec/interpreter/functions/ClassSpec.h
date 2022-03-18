#pragma once

#include "../specHelper.h"

go_bandit([](){
    describe("class() definition", []() {
        before_each([&](){

        });
        after_each([&](){
            NativeFunctions::GetSingleton().Clear();
        });
        xit("can define a type with a name", [&](){
            auto context = ContextImpl();
//            NativeFunctions::GetSingleton().RegisterFunction("gimmeVariableFn", [&receivedVariables](FunctionInvocationParams& params){
//                for (const auto& paramName : params.ParamNames()) {
//                    receivedVariables.emplace_back(std::format("Received parameter {} of type {} and value '{}'", paramName, params.TypeName(paramName), params.GetText(paramName)));
//                }
//                return FunctionInvocationResponse::ReturnVoid();
//            });

            Eval(context, R"(

)");
        });
        xit("can define a type with a name and description", [&](){});
        xit("can define a type with fields", [&](){});
        xit("can define public or private fields", [&](){});
        xit("can define a type with instance methods", [&](){});
        xit("can define public or private instance methods", [&](){});
        xit("can define a type with full properties", [&](){});
        xit("can define public or private full properties", [&](){});

//        xit("can define a type with a base class", [&](){});
//        xit("can define a type which imports other class bodies", [&](){});
    });
});
