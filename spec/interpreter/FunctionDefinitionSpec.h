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
            AssertThat(context.GetFunctionInfo("hello").GetName(), Equals("hello"));
            AssertThat(context.GetFunctionInfo("hello").GetNamespace(), Equals(""));
        });
        it("can define void function with a namespace", [&](){
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
        it("can define void function with a description (docstring)", [&](){
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
            AssertThat(context.GetFunctionInfo("hello").GetDocString(), Equals("This is the hello function\n\nIt has multiple lines!"));
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
        it("can define void native function", [&](){
            auto context = ContextImpl();

            Eval(context, R"(
- hello():
    :native:
- world():
)");

            AssertThat(context.GetFunctionInfo("hello").IsNative(), IsTrue());
            AssertThat(context.GetFunctionInfo("world").IsNative(), IsFalse());
        });
        it("can define void function with a parameter", [&](){
            auto context = ContextImpl();

            Eval(context, R"(
- hello():
    :: This is the hello function
    params:
    - foo: SomeType
      :: This is the foo param
)");
            auto& fn = context.GetFunctionInfo("hello");

            AssertThat(fn.GetDocString(), Equals("This is the hello function"));
            AssertThat(fn.GetParameterCount(), Equals(1));
            AssertThat(fn.HasParameterName("foo"), IsTrue());
            AssertThat(fn.HasParameterName("thisDoesNotExist"), IsFalse());
            AssertThat(fn.GetParameter(0).GetName(), Equals("foo"));
            AssertThat(fn.GetParameter("foo").GetName(), Equals("foo"));
            AssertThrows(FunctionInfo::FunctionParameterNotFound, fn.GetParameter(69));
            AssertThat(LastException<FunctionInfo::FunctionParameterNotFound>().what(), Is().Containing("???"));
            AssertThrows(FunctionInfo::FunctionParameterNotFound, fn.GetParameter("sixty nine"));
            AssertThat(LastException<FunctionInfo::FunctionParameterNotFound>().what(), Is().Containing("sixty nine ????"));

            auto& param = fn.GetParameter("foo");
            AssertThat(param.GetName(), Equals("foo"));
            AssertThat(param.GetTypeName(), Equals("SomeType"));
            AssertThat(param.GetDocString(), Equals("This is the foo param"));
        });
        xit("can define void function with multiple parameters", [&](){});
        xit("can define void function with body", [&](){});
        xit("can define function with return type", [&](){});
    });
});
