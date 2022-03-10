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
	ASSERT_EQ("Hello", "World");
	auto expando = YAMLtoExpando(R"(
hello: world
)");

	ASSERT_TRUE(expando.IsMap());
}
