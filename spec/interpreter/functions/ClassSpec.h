#pragma once

#include "../specHelper.h"

#include <SkyScript/Interpreter/Functions/Class.h>

go_bandit([](){
    describe("class() definition", []() {
        before_each([&](){ SkyScript::Interpreter::Functions::Class::Register(); });
        after_each([&](){ NativeFunctions::GetSingleton().Clear(); });
        it("can define a type with a name", [&](){
            auto context = ContextImpl();
            AssertThat(context.TypeCount(), Equals(0));

            Eval(context, R"(
# TODO move this into a helper :)
- class():
    :native: stdlib::class
    :custom_params:

- class:
    :name: Dog
)");
            AssertThat(context.TypeCount(), Equals(1));
            AssertThat(context.TypeExists("Dog"), IsTrue());
            AssertThat(context.GetTypeInfo("Dog").GetFullName(), Equals("::Dog"));
        });
        it("can define a type with a name, namespace, and description", [&](){
            auto context = ContextImpl();
            AssertThat(context.TypeCount(), Equals(0));

            Eval(context, R"(
# TODO move this into a helper :)
- class():
    :native: stdlib::class
    :custom_params:

- class:
    :name: Dog
    :namespace: animals
    :: Represents a dawg!
)");
            AssertThat(context.TypeCount(), Equals(1));
            AssertThat(context.TypeExists("Dog"), IsTrue());

            auto& type = context.GetTypeInfo("Dog");
            AssertThat(type.GetName(), Equals("Dog"));
            AssertThat(type.GetNamespace(), Equals("animals"));
            AssertThat(type.GetFullName(), Equals("animals::Dog"));
            AssertThat(type.GetDocString(), Equals("Represents a dawg!"));
        });
        xit("can define a type with fields", [&](){});
        xit("can define public or private fields", [&](){});
        xit("can define a type with instance methods", [&](){});
        xit("can define public or private instance methods", [&](){});
        xit("can define a type with full properties", [&](){});
        xit("can define public or private full properties", [&](){});

//        xit("can define a type with a base class", [&](){});
//        xit("can define a type which imports other class bodies", [&](){});
    });
});
