#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Variable Declaration and Assignment", [](){
        xit("can declare a primitive __string__ variable without a value", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- AnyType foo:
)");

            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());
//            AssertThat(context.GetVariable("foo").GetTypeName(), Equals("string"));
        });
        xit("can declare and assign a primitive __string__ variable with a value", [&](){});
        xit("has implicit typing for integers", [&](){});
        xit("has implicit typing for floats", [&](){});
        xit("has implicit typing for booleans", [&](){});
        xit("has implicit typing for strings", [&](){});
    });
});
