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
        it("can declare an bool variable", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- bool foo =: true
- bool bar =: false
)");
            AssertThat(context.VariableCount(), Equals(2));
            AssertThat(context.VariableExists("foo"), IsTrue());
            AssertThat(context.VariableExists("bar"), IsTrue());

            auto& foo = context.GetVariable("foo");
            AssertThat(foo.GetName(), Equals("foo"));
            AssertThat(foo.GetTypeName(), Equals("bool"));

            auto& fooValue = foo.GetTypedValue();
            AssertThat(fooValue.GetTypeName(), Equals("bool"));
            AssertThat(fooValue.GetValue<bool>(), Equals(true));
            AssertThat(fooValue.GetBoolValue(), Equals(true));

            auto& bar = context.GetVariable("bar");
            AssertThat(bar.GetName(), Equals("bar"));
            AssertThat(bar.GetTypeName(), Equals("bool"));

            auto& barValue = bar.GetTypedValue();
            AssertThat(barValue.GetTypeName(), Equals("bool"));
            AssertThat(barValue.GetValue<bool>(), Equals(false));
            AssertThat(barValue.GetBoolValue(), Equals(false));
        });
        it("has implicit typing for strings", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- foo =: hello, this is the value of foo!
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("stdlib::string"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("stdlib::string"));
            AssertThat(value.GetValue<std::string>(), Equals("hello, this is the value of foo!"));
            AssertThat(value.GetStringValue(), Equals("hello, this is the value of foo!"));
        });
        it("has implicit typing for integers", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- foo =: 69
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("stdlib::int"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("stdlib::int"));
            AssertThat(value.GetValue<int64_t>(), Equals(69));
            AssertThat(value.GetIntValue(), Equals(69));
        });
        it("has implicit typing for floats", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- foo =: 69.420
)");
            AssertThat(context.VariableCount(), Equals(1));
            AssertThat(context.VariableExists("foo"), IsTrue());

            auto& variable = context.GetVariable("foo");
            AssertThat(variable.GetName(), Equals("foo"));
            AssertThat(variable.GetTypeName(), Equals("stdlib::float"));

            auto& value = variable.GetTypedValue();
            AssertThat(value.GetTypeName(), Equals("stdlib::float"));
            AssertThat(value.GetValue<double>(), Equals(69.420));
            AssertThat(value.GetFloatValue(), Equals(69.420));
        });
        it("has implicit typing for booleans", [&](){
            auto context = ContextImpl();
            AssertThat(context.VariableCount(), Equals(0));
            AssertThat(context.VariableExists("foo"), IsFalse());

            Eval(context, R"(
- foo =: true
- bar =: false
)");
            AssertThat(context.VariableCount(), Equals(2));
            AssertThat(context.VariableExists("foo"), IsTrue());
            AssertThat(context.VariableExists("bar"), IsTrue());

            auto& foo = context.GetVariable("foo");
            AssertThat(foo.GetName(), Equals("foo"));
            AssertThat(foo.GetTypeName(), Equals("stdlib::bool"));

            auto& fooValue = foo.GetTypedValue();
            AssertThat(fooValue.GetTypeName(), Equals("stdlib::bool"));
            AssertThat(fooValue.GetValue<bool>(), Equals(true));
            AssertThat(fooValue.GetBoolValue(), Equals(true));

            auto& bar = context.GetVariable("bar");
            AssertThat(bar.GetName(), Equals("bar"));
            AssertThat(bar.GetTypeName(), Equals("stdlib::bool"));

            auto& barValue = bar.GetTypedValue();
            AssertThat(barValue.GetTypeName(), Equals("stdlib::bool"));
            AssertThat(barValue.GetValue<bool>(), Equals(false));
            AssertThat(barValue.GetBoolValue(), Equals(false));
        });
    });
});
