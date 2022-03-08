#pragma once

#include "TestHelper.h"

#include <SkyScript/ScriptFile.h>

class ParsingClassDefinitionsTest : public SkyScriptIntegrationTest {};

TEST_F(ParsingClassDefinitionsTest, ParseClassWithName) {
	auto context = Eval(R"(
class:
	:name: Dog
)");

	ASSERT_EQ(context.GetTypeCount(), 1);
	ASSERT_TRUE(context.TypeExists("Dog"));
}
