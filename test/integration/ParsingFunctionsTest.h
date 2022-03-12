#pragma once

#include "TestHelper.h"

#include <SkyScript/Context.h>

class ParsingFunctionsTest : public SkyScriptIntegrationTest {};

TEST_F(ParsingFunctionsTest, ParseSimpleFunction) {
	auto context = Context();

	ASSERT_EQ(context.FunctionInfos.size(), 0);
	ASSERT_FALSE(context.FunctionInfos.contains("sayHello"));

	Eval(context, R"(
sayHello():
	:: This is a function
	message: string
	-> : print ${message}
)");

	ASSERT_EQ(context.FunctionInfos.size(), 1);
	ASSERT_TRUE(context.FunctionInfos.contains("sayHello"));

	auto functionInfo = context.FunctionInfos["sayHello"];
	ASSERT_EQ(functionInfo.GetName(), "sayHello");
//	ASSERT_EQ(functionInfo.)
}
