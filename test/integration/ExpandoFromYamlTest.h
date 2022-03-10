#pragma once

#include "TestHelper.h"

#include <SkyScript/ExpandoDocumentReader.h>
#include <SkyScript/YamlReader.h>

#include <utility>

#include <yaml-cpp/yaml.h>

#include <map>

class ExpandoFromYamlTest : public SkyScriptIntegrationTest {
protected:
	static Expando YAMLtoExpando(std::string yamlText) {
		auto reader = YamlReader(std::move(yamlText));
		return ExpandoDocumentReader::ReadDocument(reader);
	}
};

TEST_F(ExpandoFromYamlTest, ExpandoFromYamlTest_Foo) {

	std::string yaml = R"(
hello: world
hi: "there"
key: 420.69
)";
	auto node = YAML::Load(yaml);
	std::cout << std::format("Is top level node a MAP {}", node.IsMap());
	for (YAML::const_iterator iterator = node.begin(); iterator != node.end(); ++iterator) {
		auto type = iterator->first.Type();
		switch (type) {
			case YAML::NodeType::value::Map:
				std::cout << std::format("First is map!");
				break;
			case YAML::NodeType::value::Sequence:
				std::cout << std::format("First is seq!");
				break;
			case YAML::NodeType::value::Scalar:
				std::cout << std::format("First is scalar! {} : [{}]", iterator->first.Scalar(), iterator->first.Tag());
				break;
			default:
				std::cout << "Hmm none of the other types";
				break;
		}
		auto type2 = iterator->second.Type();
		switch (type2) {
		case YAML::NodeType::value::Map:
			std::cout << std::format("Second is map!");
			break;
		case YAML::NodeType::value::Sequence:
			std::cout << std::format("Second is seq!");
			break;
		case YAML::NodeType::value::Scalar:
			std::cout << std::format("Second is scalar! {} : [{}]", iterator->second.Scalar(), iterator->second.Tag());
			break;
		default:
			std::cout << "Hmm none of the other types";
			break;
		}
	}



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
