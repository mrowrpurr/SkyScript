#pragma once

#include "TestHelper.h"
#include <snowhouse/snowhouse.h>

using namespace snowhouse;

class HelloTest : public SkyScriptUnitTest {};

TEST_F(HelloTest, HelloWorld) {
	ASSERT_EQ("Hello", "Hello");
}
