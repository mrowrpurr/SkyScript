#pragma once

#include "../specHelper.h"

#include <SkyScript/Interpreter/Functions/Class.h>

//go_bandit([](){
//    describe("class() definition", []() {
//        ContextImpl context;
//        before_each([&context](){
//            SkyScript::Interpreter::Functions::Class::Register();
//            context.Reset();
//            Eval(context, R"(
//- class():
//    :native: stdlib::class
//    :custom_params:
//)");
//        });
//        after_each([&](){ NativeFunctions::GetSingleton().Clear(); });
//        it("can define a type with a name", [&context](){
//            AssertThat(context.TypeCount(), Equals(0));
//
//            Eval(context, R"(
//- class:
//    :name: Dog
//)");
//            AssertThat(context.TypeCount(), Equals(1));
//            AssertThat(context.TypeExists("Dog"), IsTrue());
//            AssertThat(context.GetTypeInfo("Dog").GetFullName(), Equals("::Dog"));
//        });
//        it("can define a type with a name, namespace, and description", [&context](){
//            AssertThat(context.TypeCount(), Equals(0));
//
//            Eval(context, R"(
//- class:
//    :name: Dog
//    :namespace: animals
//    :: Represents a dawg!
//)");
//            AssertThat(context.TypeCount(), Equals(1));
//            AssertThat(context.TypeExists("Dog"), IsTrue());
//
//            auto& type = context.GetTypeInfo("Dog");
//            AssertThat(type.GetName(), Equals("Dog"));
//            AssertThat(type.GetNamespace(), Equals("animals"));
//            AssertThat(type.GetFullName(), Equals("animals::Dog"));
//            AssertThat(type.GetDocString(), Equals("Represents a dawg!"));
//        });
//        xit("can define a type with fields", [&](){
//            Eval(context, R"(
//- class:
//    :name: Dog
//    name: string
//    age: int
//)");
//            auto& type = context.GetTypeInfo("Dog");
//            AssertThat(type.GetName(), Equals("Dog"));
//
//            // Generic Member lookup interface
//            AssertThat(type.MemberCount(), Equals(2));
////            AssertThat(type.MemberExists("name"), IsTrue());
////            AssertThat(type.MemberExists("age"), IsTrue());
////            AssertThat(type.MemberExists("foo"), IsFalse());
////            AssertThat(type.GetMemberInfo("name").GetName(), Equals("name"));
////            AssertThat(type.GetMemberInfo("age").GetName(), Equals("age"));
////            AssertThat(type.GetMemberInfo("name").GetTypeName(), Equals("string"));
////            AssertThat(type.GetMemberInfo("age").GetTypeName(), Equals("int"));
////            // AssertThrows member not found
////
////            // Specific Field lookup interface
////            AssertThat(type.FieldCount(), Equals(2));
////            AssertThat(type.FieldExists("name"), IsTrue());
////            AssertThat(type.FieldExists("age"), IsTrue());
////            AssertThat(type.FieldExists("foo"), IsFalse());
////            AssertThat(type.GetFieldInfo("name").GetName(), Equals("name"));
////            AssertThat(type.GetFieldInfo("age").GetName(), Equals("age"));
////            AssertThat(type.GetFieldInfo("name").GetTypeName(), Equals("string"));
////            AssertThat(type.GetFieldInfo("age").GetTypeName(), Equals("int"));
//            // AssertThrows field not found
//        });
//        xit("can define public or private fields", [&](){});
//        xit("can define a type with instance methods", [&](){});
//        xit("can define public or private instance methods", [&](){});
//        xit("can define a type with full properties", [&](){});
//        xit("can define public or private full properties", [&](){});
//
////        xit("can define a type with a base class", [&](){});
////        xit("can define a type which imports other class bodies", [&](){});
//    });
//});
