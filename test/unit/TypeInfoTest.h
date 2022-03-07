#pragma once

#include "TestHelper.h"

#include <SkyScript/TypeInfo.h>

class TypeInfoTest : public SkyScriptUnitTest {};

TEST_F(TypeInfoTest, TypeInfoHasName) {
	auto dogInfo = TypeInfo("Dog");
	auto catInfo = TypeInfo("Cat");

	ASSERT_EQ(dogInfo.GetName(), "Dog");
	ASSERT_EQ(catInfo.GetName(), "Cat");
}

TEST_F(TypeInfoTest, TypeInfoHasNamespace) {
	auto dogInfo = TypeInfo("Dog");
	auto catInfo = TypeInfo("Cat", "Animals");

	// Default namespace is empty
	ASSERT_EQ(dogInfo.GetNamespace(), "");

	ASSERT_EQ(catInfo.GetName(), "Cat");
	ASSERT_EQ(catInfo.GetNamespace(), "Animals");
}
