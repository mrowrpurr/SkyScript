#include "TestHelper.h"
#include <snowhouse/snowhouse.h>

#include <SkyScript/ScriptFile.h>

using namespace snowhouse;

class ScriptFileTest : public SkyScriptTestBase {};

TEST_F(ScriptFileTest, ReadScriptYaml) {
	const auto yaml = "hello: world";
	const auto folder = MkDir("Hello");
    const auto file = WriteToFile("Hello\\Script.yaml", yaml);
	const auto path = Path("Hello\\Script.yaml");

	const auto text = SkyScript::ScriptFile::GetFileText(path);

    ASSERT_EQ(std::string(text), yaml);
}
