#pragma once

#include "TestHelper.h"

#include <SkyScript/ExpandoDocumentReader.h>
#include <SkyScript/YamlReader.h>

#include <utility>

class ExpandoFromYamlTest : public SkyScriptIntegrationTest {
protected:
	static Expando YAMLtoExpando(std::string yamlText) {
		auto reader = YamlReader(std::move(yamlText));
		return ExpandoDocumentReader::ReadDocument(reader);
	}
};

TEST_F(ExpandoFromYamlTest, ExpandoFromYamlTest_Foo) {
	auto helloMap = YAMLtoExpando(R"(
hello: world
)");
	auto fooList = YAMLtoExpando(R"(
- foo
- bar
)");

	// Verify hello map!
	ASSERT_TRUE(helloMap.IsMap());
//	ASSERT_TRUE(helloMap.HasKey("hello"));
	 ASSERT_FALSE(helloMap.IsSeq());

	// Verify foo list!
	ASSERT_FALSE(fooList.IsMap());
//	ASSERT_FALSE(fooList.HasKey("hello"));
	ASSERT_TRUE(fooList.IsSeq());
}
