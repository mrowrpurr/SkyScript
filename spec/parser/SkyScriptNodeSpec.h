#pragma once

#include "specHelper.h"

#include <SkyScript/Parsers/YAML.h>
#include <SkyScript/Parsers/Exceptions.h>

using namespace SkyScript::Parsers::Exceptions;

go_bandit([](){
    describe("Accessing Data in SkyScriptNodes", [](){
        it("can iterate through map nodes", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
hello: world
foo: bar
)");
            bool foundHello = false;
            bool foundFoo = false;
            bool foundSomethingElse = false;
            for (const auto& key : node.GetKeys()) {
                if (key == "hello") {
                    foundHello = true;
                } else if (key == "foo") {
                    foundFoo = true;
                } else {
                    foundSomethingElse = true;
                }
            }

            AssertThat(foundHello, IsTrue());
            AssertThat(foundFoo, IsTrue());
            AssertThat(foundSomethingElse, IsFalse());
        });
        xit("can iterate through array nodes", [&](){});
        it("can get the first key and value of a map node", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
hello: world
)");
            AssertThat(node.GetSingleKey(), Equals("hello"));
            AssertThat(node.GetSingleValue().GetStringValue(), Equals("world"));

            auto nodeWithMultipleKeys = SkyScript::Parsers::YAML::Parse(R"(
hello: world
foo: bar
)");
            AssertThrows(SkyScriptNodeSingleMapNotFound, nodeWithMultipleKeys.GetSingleKey());
            AssertThat(LastException<SkyScriptNodeSingleMapNotFound>().what(), Is().Containing("not a single map"));
            AssertThrows(SkyScriptNodeSingleMapNotFound, nodeWithMultipleKeys.GetSingleValue());
            AssertThat(LastException<SkyScriptNodeSingleMapNotFound>().what(), Is().Containing("not a single map"));
        });
    });
});
