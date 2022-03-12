#pragma once

#include "TestHelper.h"

#include <SkyScript/ScriptNode.h>
#include <SkyScript/Parsing/YAMLtoScriptNode.h>

class ParsingIntoScriptNodesTest : public SkyScriptUnitTest {
protected:
//	static std::unique_ptr<ScriptNode> Parse(const std::string& yaml) {
//		auto node = SkyScript::Parsing::YAML::YAMLtoScriptNode(yaml);
//		return std::make_unique<ScriptNodeImpl>(node);
//	}
};

TEST_F(ParsingIntoScriptNodesTest, SimpleString_ParsingIntoScriptNodesTest) {

	SkyScript::Parsing::YAML::Hello();


	ASSERT_TRUE(true);



//	auto node = SkyScript::ScriptNodeImpl();
//	auto x = SkyScript::Parsing::YAML::YAMLtoScriptNode("yaml");

//	auto node = Parse(R"(
//hello: world
//foo: bar
//)");
//
//	ASSERT_TRUE(node->IsMap());
//	ASSERT_FALSE(node->IsVector());
//	ASSERT_FALSE(node->IsValue());
//
//	ASSERT_EQ(node->Size(), 2);
}
