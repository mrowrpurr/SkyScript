#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Syntax Errors", [](){
        xit("gibberish returns a syntax error", [&](){
            auto context = ContextImpl();
            AssertThat(context.HasError(), IsFalse());

            Eval(context, R"(
foo - bar -> blah whatever - hi: blahhhh
)");

            AssertThat(context.HasError(), IsTrue());
            AssertThat(context.GetError().value().GetMessage(), Contains("foo - bar -> blah whatever - hi"));
        });
        xit("invalid yaml return a syntax error", [&](){});
        xit("returns the line number and column number", [&](){});
    });
});
