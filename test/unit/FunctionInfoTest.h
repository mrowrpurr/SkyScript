#pragma once

#include "TestHelper.h"

#include <SkyScript/FunctionInfo.h>

class FunctionInfoTest : public SkyScriptUnitTest {};

TEST_F(FunctionInfoTest, FunctionInfoHasName) {
	auto fooInfo = FunctionInfo("Foo");
	auto barInfo = FunctionInfo("Bar");

	ASSERT_EQ(fooInfo.GetName(), "Foo");
	ASSERT_EQ(barInfo.GetName(), "Bar");
}

TEST_F(FunctionInfoTest, FunctionInfoHasDocString) {
	auto fooInfo = FunctionInfo("Foo");
	fooInfo.SetDocString("This is a cool function");

	auto barInfo = FunctionInfo("Bar");
	barInfo.SetDocString("This is a rad function");

	ASSERT_EQ(fooInfo.GetDocString(), "This is a cool function");
	ASSERT_EQ(barInfo.GetDocString(), "This is a rad function");
}

//TEST_F(FunctionInfoTest, FunctionInfoHasReturnTypeName) {
//
//}

//TEST_F(FunctionInfoTest, FunctionInfoHasParameters) {
//
//}

//TEST_F(FunctionInfoTest, FunctionInfoHasBody) {
//
//}
