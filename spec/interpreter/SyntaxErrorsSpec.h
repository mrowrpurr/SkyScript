#pragma once

#include "specHelper.h"

go_bandit([](){
    describe("Syntax Errors", [](){
        it("gibberish returns a syntax error", [&](){
            auto context = ContextImpl();
            AssertThat(context.HasError(), IsFalse());

            auto success = Eval(context, R"(
foo - bar -> blah whatever - hi: blahhhh
)");

            AssertThat(success, IsFalse());
            AssertThat(context.HasError(), IsTrue());
            AssertThat(context.GetError().GetMessage(), Contains("???? foo - bar -> blah whatever - hi"));
        });
        xit("invalid yaml return a syntax error", [&](){});
        xit("returns the line number and column number", [&](){});
    });
});
