#pragma once

#include "TestHelper.h"

#include <SkyScript/ScriptFile.h>

class ParsingClassDefinitionsTest : public SkyScriptIntegrationTest {};

TEST_F(ParsingClassDefinitionsTest, ParseClassWithName) {
//	auto context = Eval(R"(
//hello: world
//foo: bar
//)");
	auto content = ScriptFile::GetFileText("C:/Code/test.yaml");
	auto context = Eval(content);

	ASSERT_EQ(context.GetTypeCount(), 1);
	ASSERT_TRUE(context.TypeExists("Dog"));
}
