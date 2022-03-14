#pragma once

#include "specHelper.h"

#include <SkyScript/Reflection/Exceptions.h>

using namespace SkyScript::Reflection::Exceptions;

go_bandit([](){
    describe("Context", [](){
        it("has functions", [&](){
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
        it("has variables", [&](){
        xit("has types", [&](){
                             auto context = ContextImpl();
                             AssertThat(context.VariableCount(), Equals(0));
                             AssertThat(context.VariableExists("SomeVariable"), IsFalse());

                             auto var = VariableImpl("SomeVariable", "SomeType");
                             context.AddVariable(var);

                             AssertThat(context.VariableCount(), Equals(1));
                             AssertThat(context.VariableExists("SomeVariable"), IsTrue());
                             });
            auto context = ContextImpl();
//            AssertThat(context.TypeCount(), Equals(0));
//            AssertThat(context.TypeExists("SomeType"), IsFalse());
//
//            auto type = TypeImpl("SomeNamespace", "SomeType");
//            context.AddType(var);
//
//            AssertThat(context.TypeCount(), Equals(1));
//            AssertThat(context.TypeExists("SomeType"), IsTrue());
//
//            AssertThat(context.TypeCount(), Equals(1));
//            AssertThat(context.TypeExists("SomeType"), IsTrue());
        });
        it("GetFunctionInfo() throws an exception when not found", [&](){
            auto functionName = "This Does Not Exist!";
            auto context = ContextImpl();
            AssertThrows(FunctionNotFoundException, context.GetFunctionInfo(functionName));
            AssertThat(LastException<FunctionNotFoundException>().what(), Is().Containing("Function not found 'This Does Not Exist!'"));
        });
    });
});
