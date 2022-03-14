#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Defining Functions", [](){
        it("can define void empty function without namespace", [&](){
            auto context = ContextImpl();
            AssertThat(context.FunctionCount(), Equals(0));
            AssertThat(context.FunctionExists("hello"), IsFalse());

            Eval(context, R"(
hello():
)");

            AssertThat(context.FunctionCount(), Equals(1));
            AssertThat(context.FunctionExists("hello"), IsTrue());
        });
        it("can define void function with a namespace", [&](){
            auto context = ContextImpl();
            AssertThat(context.FunctionCount(), Equals(0));
            AssertThat(context.FunctionExists("hello"), IsFalse());
            AssertThat(context.FunctionExists("greetings::hello"), IsFalse());

            Eval(context, R"(
greetings::hello():
)");

            AssertThat(context.FunctionCount(), Equals(1));
            AssertThat(context.FunctionExists("hello"), IsTrue());
            AssertThat(context.FunctionExists("greetings::hello"), IsTrue());
        });
        xit("can define void function with a description (docstring)", [&](){
            auto context = ContextImpl();
            AssertThat(context.FunctionCount(), Equals(0));

            Eval(context, R"(
hello():
- :: This is the hello function
)");

//            AssertThat(context.GetFunctionInfo("hello").GetDocString(), Equals("This is the hello function"));
        });
        xit("can define void function with a parameter", [&](){});
        xit("can define void function with multiple parameters", [&](){});
        xit("can define void function with body", [&](){});
        xit("can define function with return type", [&](){});
    });
});
