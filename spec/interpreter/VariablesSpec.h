#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Variable Declaration and Assignment", [](){
        it("can declare a string variable", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- string foo =: hello, this is the value of foo!
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("string"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("string"));
            AssertThat(value.GetValue<std::string>(), Equals("hello, this is the value of foo!"));
            AssertThat(value.GetStringValue(), Equals("hello, this is the value of foo!"));
        });
        it("can declare an integer variable", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- int foo =: 69
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("int"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("int"));
            AssertThat(value.GetValue<int64_t>(), Equals(69));
            AssertThat(value.GetIntValue(), Equals(69));
        });
        it("can declare an float variable", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- float foo =: 69.420
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("float"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("float"));
            AssertThat(value.GetValue<double>(), Equals(69.420));
            AssertThat(value.GetFloatValue(), Equals(69.420));
        });
        xit("has implicit typing for strings", [&](){});
        xit("has implicit typing for integers", [&](){});
        xit("has implicit typing for floats", [&](){});
        xit("has implicit typing for booleans", [&](){});
    });
});
