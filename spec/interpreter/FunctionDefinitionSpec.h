#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Defining Functions", []() {
        it("can define void empty function without namespace", [&]() {
            auto context = ContextImpl();
            AssertThat(context.FunctionCount(), Equals(0));
            AssertThat(context.FunctionExists("hello"), IsFalse());

            Eval(context, R"(
hello():
)");

            AssertThat(context.FunctionCount(), Equals(1));
            AssertThat(context.FunctionExists("hello"), IsTrue());
            AssertThat(context.GetFunctionInfo("hello").GetName(), Equals("hello"));
            AssertThat(context.GetFunctionInfo("hello").GetNamespace(), Equals(""));
        });
        it("can define void function with a namespace", [&]() {
            auto context = ContextImpl();
            AssertThat(context.FunctionExists("hello"), IsFalse());
            AssertThat(context.FunctionExists("greetings::hello"), IsFalse());

            Eval(context, R"(
greetings::hello():
)");

            AssertThat(context.FunctionCount(), Equals(1));
            AssertThat(context.FunctionExists("hello"), IsTrue());
            AssertThat(context.FunctionExists("greetings::hello"), IsTrue());
            AssertThat(context.GetFunctionInfo("hello").GetName(), Equals("hello"));
            AssertThat(context.GetFunctionInfo("hello").GetNamespace(), Equals("greetings"));
        });
        it("can define void function with a description (docstring)", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
hello():
  :: This is the hello function
)");

            AssertThat(context.GetFunctionInfo("hello").GetDocString(), Equals("This is the hello function"));

            Eval(context, R"(
hello():
  :: |
    This is the hello function

    It has multiple lines!
)");
            AssertThat(context.GetFunctionInfo("hello").GetDocString(),
                       Equals("This is the hello function\n\nIt has multiple lines!"));
        });
        it("can define multiple functions", [&]() {
            auto context = ContextImpl();
            AssertThat(context.FunctionExists("hello"), IsFalse());
            AssertThat(context.FunctionExists("world"), IsFalse());

            Eval(context, R"(
- hello():
- world():
)");

            AssertThat(context.FunctionCount(), Equals(2));
            AssertThat(context.FunctionExists("hello"), IsTrue());
            AssertThat(context.FunctionExists("world"), IsTrue());
        });
        it("can define void native function", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
- hello():
    :native:
- world():
)");

            AssertThat(context.GetFunctionInfo("hello").IsNative(), IsTrue());
            AssertThat(context.GetFunctionInfo("world").IsNative(), IsFalse());
        });
        it("can define void function which takes custom parameters", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
- hello():
    :: This is the hello function
    :custom_params:
- regularParams():
    params:
    - hello: string
- noParams():
)");
            auto &hello = context.GetFunctionInfo("hello");
            AssertThat(hello.HasParameters(), IsFalse());
            AssertThat(hello.UsesCustomParameters(), IsTrue());

            auto &regular = context.GetFunctionInfo("regularParams");
            AssertThat(regular.HasParameters(), IsTrue());
            AssertThat(regular.UsesCustomParameters(), IsFalse());

            auto &noParams = context.GetFunctionInfo("noParams");
            AssertThat(noParams.HasParameters(), IsFalse());
            AssertThat(noParams.UsesCustomParameters(), IsFalse());
        });
        it("can define void function with a parameter", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
- hello():
    :: This is the hello function
    params:
    - foo: SomeType
      :: This is the foo param
- noParams():
)");
            AssertThat(context.GetFunctionInfo("noParams").HasParameters(), IsFalse());

            auto &fn = context.GetFunctionInfo("hello");

            AssertThat(fn.HasParameters(), IsTrue());
            AssertThat(fn.GetDocString(), Equals("This is the hello function"));
            AssertThat(fn.GetParameterCount(), Equals(1));
            AssertThat(fn.HasParameterName("foo"), IsTrue());
            AssertThat(fn.HasParameterName("thisDoesNotExist"), IsFalse());
            AssertThat(fn.GetParameter(0).GetName(), Equals("foo"));
            AssertThat(fn.GetParameter("foo").GetName(), Equals("foo"));
            AssertThrows(FunctionInfo::FunctionParameterNotFound, fn.GetParameter(69));
            AssertThat(LastException<FunctionInfo::FunctionParameterNotFound>().what(),
                       Is().Containing("No parameter of hello found by index 69"));
            AssertThrows(FunctionInfo::FunctionParameterNotFound, fn.GetParameter("sixty nine"));
            AssertThat(LastException<FunctionInfo::FunctionParameterNotFound>().what(),
                       Is().Containing("No parameter of hello found by name 'sixty nine'"));

            auto &param = fn.GetParameter("foo");
            AssertThat(param.GetName(), Equals("foo"));
            AssertThat(param.GetTypeName(), Equals("SomeType"));
            AssertThat(param.GetDocString(), Equals("This is the foo param"));
        });
        it("can define void function with multiple parameters", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
- hello():
    params:
    - foo: FooType
      :: This is the foo param
    - bar: BarType
      :: This is the bar param
)");
            auto &fn = context.GetFunctionInfo("hello");

            AssertThat(fn.HasParameters(), IsTrue());
            AssertThat(fn.GetParameterCount(), Equals(2));
            AssertThat(fn.GetParameter("foo").GetDocString(), Equals("This is the foo param"));
            AssertThat(fn.GetParameter("foo").GetTypeName(), Equals("FooType"));
            AssertThat(fn.GetParameter("bar").GetDocString(), Equals("This is the bar param"));
            AssertThat(fn.GetParameter("bar").GetTypeName(), Equals("BarType"));
        });
        xit("can define void function with parameter default value (string expression)", [&]() {});
        xit("can define void function with parameter default value (node expression)", [&]() {});
        xit("can define void function with splat ... parameter", [&]() {});
        it("can define function with return type", [&]() {
            auto context = ContextImpl();
            Eval(context, R"(
- hello():
- void world():
- string foo():
- stdlib::string bar():
)");
            AssertThat(context.GetFunctionInfo("hello").GetReturnTypeName(), Equals("void"));
            AssertThat(context.GetFunctionInfo("world").GetReturnTypeName(), Equals("void"));
            AssertThat(context.GetFunctionInfo("foo").GetReturnTypeName(), Equals("string"));
            AssertThat(context.GetFunctionInfo("bar").GetReturnTypeName(), Equals("stdlib::string"));
        });
        xit("can define void function with body", [&]() {});
    });
});
