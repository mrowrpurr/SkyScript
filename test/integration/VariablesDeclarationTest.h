#include "TestHelper.h"
#include <snowhouse/snowhouse.h>
#include <SkyScript/Context.h>
#include <SkyScript/Evaluator.h>

using namespace snowhouse;

class VariablesDeclarationTest : public SkyScriptTestBase {};

TEST_F(VariablesDeclarationTest, AssignStringVariabel) {
	const auto* yaml = "hello =: world";
	auto folder = MkDir("Hello");
	auto file = WriteToFile("Hello\\Script.yaml", yaml);
	auto path = Path("Hello\\Script.yaml");
	auto context = new SkyScript::Context();
//	auto evaluator = SkyScript::Evaluator();

	ASSERT_EQ(0, context->GetLocalVariables().size());
}
