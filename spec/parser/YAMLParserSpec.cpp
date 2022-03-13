#include "specHelper.h"

#include <SkyScript/Parsers/YAML.h>

go_bandit([](){
    describe("Parsing YAML to ScriptNodes", [](){
        it("can parse simple string map", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
hello: world
foo: bar
)");
            AssertThat(node.IsMap(), IsTrue());
            AssertThat(node.IsArray(), IsFalse());
            AssertThat(node.IsValue(), IsFalse());
            AssertThat(node.Size(), Equals(2));
            AssertThat(node.ContainsKey("hello"), IsTrue());
            AssertThat(node.ContainsKey("foo"), IsTrue());
            AssertThat(node["hello"].GetStringValue(), Equals("world"));
            AssertThat(node["foo"].GetStringValue(), Equals("bar"));
        });
        it("can parse a simple string array", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
- hi
- hello
- world
)");
            AssertThat(node.IsArray(), IsTrue());
            AssertThat(node.IsMap(), IsFalse());
            AssertThat(node.IsValue(), IsFalse());
            AssertThat(node.Size(), Equals(3));
            AssertThat(node[0].GetStringValue(), Equals("hi"));
            AssertThat(node[1].GetStringValue(), Equals("hello"));
            AssertThat(node[2].GetStringValue(), Equals("world"));
        });
        it("can parse integer values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: 69
float: 420.69
string: hello
bool: true
bool: false
)");
            AssertThat(node["int"].GetStringValue(), Equals("69"));
            AssertThat(node["int"].IsString(), IsFalse());
            AssertThat(node["int"].IsInteger(), IsTrue());
            AssertThat(node["int"].IsFloat(), IsFalse());
            AssertThat(node["int"].IsBool(), IsFalse());
        });
        it("can parse float values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: 69
float: 420.69
string: hello
true: true
false: false
)");
            AssertThat(node["float"].GetStringValue(), Equals("420.69"));
            AssertThat(node["float"].IsString(), IsFalse());
            AssertThat(node["float"].IsInteger(), IsFalse());
            AssertThat(node["float"].IsFloat(), IsTrue());
            AssertThat(node["float"].IsBool(), IsFalse());
        });
        it("can parse bool values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: 69
float: 420.69
string: hello
true: true
false: false
)");
            AssertThat(node["true"].GetStringValue(), Equals("true"));
            AssertThat(node["true"].IsString(), IsFalse());
            AssertThat(node["true"].IsInteger(), IsFalse());
            AssertThat(node["true"].IsFloat(), IsFalse());
            AssertThat(node["true"].IsBool(), IsTrue());

            AssertThat(node["false"].GetStringValue(), Equals("false"));
            AssertThat(node["false"].IsString(), IsFalse());
            AssertThat(node["false"].IsInteger(), IsFalse());
            AssertThat(node["false"].IsFloat(), IsFalse());
            AssertThat(node["false"].IsBool(), IsTrue());
        });
        it("can parse string values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: 69
float: 420.69
string: hello
true: true
false: false
)");
            AssertThat(node["string"].GetStringValue(), Equals("hello"));
            AssertThat(node["string"].IsString(), IsTrue());
            AssertThat(node["string"].IsInteger(), IsFalse());
            AssertThat(node["string"].IsFloat(), IsFalse());
            AssertThat(node["string"].IsBool(), IsFalse());
        });
        it("can parse single quoted string values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: '69'
float: '420.69'
string: 'hello'
true: "true"
false: "false"
)");
            AssertThat(node["int"].GetStringValue(), Equals("69"));
            AssertThat(node["int"].IsString(), IsTrue());

            AssertThat(node["float"].GetStringValue(), Equals("420.69"));
            AssertThat(node["float"].IsString(), IsTrue());

            AssertThat(node["string"].IsString(), IsTrue());

            AssertThat(node["true"].GetStringValue(), Equals("true"));
            AssertThat(node["true"].IsString(), IsTrue());

            AssertThat(node["false"].GetStringValue(), Equals("false"));
            AssertThat(node["false"].IsString(), IsTrue());
        });
        it("can parse double quoted string values", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: "69"
float: "420.69"
string: "hello"
true: "true"
false: "false"
)");
            AssertThat(node["int"].GetStringValue(), Equals("69"));
            AssertThat(node["int"].IsString(), IsTrue());

            AssertThat(node["float"].GetStringValue(), Equals("420.69"));
            AssertThat(node["float"].IsString(), IsTrue());

            AssertThat(node["string"].IsString(), IsTrue());

            AssertThat(node["true"].GetStringValue(), Equals("true"));
            AssertThat(node["true"].IsString(), IsTrue());

            AssertThat(node["false"].GetStringValue(), Equals("false"));
            AssertThat(node["false"].IsString(), IsTrue());
        });
        it("can parse multiline string values - pipes", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: |
    69
float: |
    420.69
string: |
    hello
true: |
    true
false: |
    false
)");
            AssertThat(node["int"].GetStringValue(), Equals("69\n"));
            AssertThat(node["int"].IsString(), IsTrue());

            AssertThat(node["float"].GetStringValue(), Equals("420.69\n"));
            AssertThat(node["float"].IsString(), IsTrue());

            AssertThat(node["string"].IsString(), IsTrue());

            AssertThat(node["true"].GetStringValue(), Equals("true\n"));
            AssertThat(node["true"].IsString(), IsTrue());

            AssertThat(node["false"].GetStringValue(), Equals("false\n"));
            AssertThat(node["false"].IsString(), IsTrue());
        });
        it("can parse multiline string values - angle brackets", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
int: >
    69
float: >
    420.69
string: >
    hello
true: >
    true
false: >
    false
)");
            AssertThat(node["int"].GetStringValue(), Equals("69\n"));
            AssertThat(node["int"].IsString(), IsTrue());

            AssertThat(node["float"].GetStringValue(), Equals("420.69\n"));
            AssertThat(node["float"].IsString(), IsTrue());

            AssertThat(node["string"].IsString(), IsTrue());

            AssertThat(node["true"].GetStringValue(), Equals("true\n"));
            AssertThat(node["true"].IsString(), IsTrue());

            AssertThat(node["false"].GetStringValue(), Equals("false\n"));
            AssertThat(node["false"].IsString(), IsTrue());
        });
    });

    describe("Accessing Data in ScriptNodes", [](){
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
        it("can get the first key of a map node", [&](){
            auto node = SkyScript::Parsers::YAML::Parse(R"(
hello: world
)");
            AssertThat(node.GetSingleKey(), Equals("hello"));

            auto nodeWithMultipleKeys = SkyScript::Parsers::YAML::Parse(R"(
hello: world
foo: bar
)");
            AssertThat(nodeWithMultipleKeys.GetSingleKey(), Equals(""));
        });
    });
});
