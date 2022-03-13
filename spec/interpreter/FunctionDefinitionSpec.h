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
        xit("can define void function with a namespace", [&](){});
        xit("can define void function with a description (docstring)", [&](){});
        xit("can define void function with a parameter", [&](){});
        xit("can define void function with multiple parameters", [&](){});
        xit("can define void function with body", [&](){});
    });
});
