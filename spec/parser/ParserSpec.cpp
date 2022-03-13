#include "../specHelper.h"

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
    });
});

int main(int argc, char* argv[]) { return runBandit(argc, argv); }
