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
           AssertThat(node.Size(), Equals(2));
//           AssertThat(node.ContainsKey("hello"), IsTrue());
       });
    });
});

int main(int argc, char* argv[]) { return runBandit(argc, argv); }
