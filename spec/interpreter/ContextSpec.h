#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Interpreter Context", [](){
        it("can add functions", [&](){
            auto fn = FunctionInfoImpl("myNamespace", "myFunction");

            auto context = ContextImpl();
            AssertThat(context.FunctionCount(), Equals(0));
            AssertThat(context.FunctionExists("myNamespace::myFunction"), IsFalse());
            AssertThat(context.FunctionExists("myFunction"), IsFalse());
            AssertThat(context.FunctionExists("thisDoesNotExist"), IsFalse());

            context.AddFunction(fn);

            AssertThat(context.FunctionCount(), Equals(1));
            AssertThat(context.FunctionExists("myNamespace::myFunction"), IsTrue());
            AssertThat(context.FunctionExists("myFunction"), IsTrue());
            AssertThat(context.FunctionExists("thisDoesNotExist"), IsFalse());
        });
    });
});
