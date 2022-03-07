#include "TestHelper.h"
#include <snowhouse/snowhouse.h>
#include <SkyScript/Context.h>
#include <SkyScript/Evaluator.h>

using namespace snowhouse;

class VariablesDeclarationTest : public SkyScriptTestBase {};

TEST_F(VariablesDeclarationTest, AssignStringVariable) {
	auto context = new SkyScript::Context();

	ASSERT_EQ(0, context->GetLocalVariables().size());

	auto evaluator = new SkyScript::Evaluator();
	evaluator->Evaluate(*context, "hello: world");

	ASSERT_EQ(1, context->GetLocalVariables().size());
	ASSERT_TRUE(context->GetLocalVariables().contains("hello"));
}







// PRINT OUT THE VARS!
//const auto& vars = context->GetLocalVariables();
//for (const auto& [key, val] : vars) {
//std::cout << std::format("KEY: {} VAL: {}", key, val);
//}
