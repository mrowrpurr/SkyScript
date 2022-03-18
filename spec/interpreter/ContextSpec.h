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
            auto variable = VariableImpl("foo", "stdlib::string");

            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            context.AddVariable(variable);

            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());
        });
        it("has types", [&](){
            auto type = TypeImpl("animals", "Dog");

            auto context = ContextImpl();
            AssertThat(context.TypeCount(), Equals(0));
            AssertThat(context.TypeExists("Dog"), IsFalse());
            AssertThat(context.TypeExists("animals::Dog"), IsFalse());

            context.AddType(type);

            AssertThat(context.TypeCount(), Equals(1));
            AssertThat(context.TypeExists("Dog"), IsTrue());
            AssertThat(context.TypeExists("animals::Dog"), IsTrue());
            AssertThat(context.GetTypeInfo("Dog").GetFullName(), Equals("animals::Dog"));
        });
        it("GetFunctionInfo() throws an exception when not found", [&](){
            auto functionName = "This Does Not Exist!";
            auto context = ContextImpl();
            AssertThrows(FunctionNotFoundException, context.GetFunctionInfo(functionName));
            AssertThat(LastException<FunctionNotFoundException>().what(), Is().Containing("Function not found 'This Does Not Exist!'"));
        });
        it("can have parent context(s)", [&](){});
        xit("function lookup traverses parent contexts", [&](){});
        xit("variable lookup traverses parent contexts", [&](){});
        xit("type lookup traverses parent contexts", [&](){});
    });
});
