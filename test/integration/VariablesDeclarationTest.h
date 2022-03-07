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

	ASSERT_EQ(context->GetLocalVariables()["hello"], "world");
	evaluator->Evaluate(*context, "skyrim: is awesome!");

	ASSERT_EQ(2, context->GetLocalVariables().size());
	ASSERT_TRUE(context->GetLocalVariables().contains("skyrim"));
	ASSERT_EQ(context->GetLocalVariables()["skyrim"], "is awesome!");
}
