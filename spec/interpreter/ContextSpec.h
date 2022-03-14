#pragma once

#include "specHelper.h"

#include <SkyScript/Reflection/Exceptions.h>

using namespace SkyScript::Reflection::Exceptions;

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
        xit("can add variables", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));

            // ...

            AssertThat(context.VariableCount(), Equals(1));
        });
        it("GetFunctionInfo() throws an exception when not found", [&](){
            auto functionName = "This Does Not Exist!";
            auto context = ContextImpl();
            AssertThrows(FunctionNotFoundException, context.GetFunctionInfo(functionName));
            AssertThat(LastException<FunctionNotFoundException>().what(), Is().Containing("Function not found 'This Does Not Exist!'"));
        });
    });
});
