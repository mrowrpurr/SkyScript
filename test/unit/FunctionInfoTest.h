#pragma once

#include "TestHelper.h"

#include <SkyScript/FunctionInfo.h>

class FunctionInfoTest : public SkyScriptUnitTest {};

TEST_F(FunctionInfoTest, FunctionHasName) {
	auto dogInfo = FunctionInfo("Foo");
	auto catInfo = FunctionInfo("Bar");

	ASSERT_EQ(dogInfo.GetName(), "Foo");
	ASSERT_EQ(catInfo.GetName(), "Bar");
}
