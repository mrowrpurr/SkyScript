#pragma once

#include "TestHelper.h"

class ParsingClassDefinitionsTest : public SkyScriptIntegrationTest {};

TEST_F(ParsingClassDefinitionsTest, ParseClassWithName) {
	auto context = Eval(R"(
class:
	:name: hello
)");

	ASSERT_EQ(context.GetTypeCount(), 1);
	ASSERT_TRUE(context.TypeExists("Dog"));
}
