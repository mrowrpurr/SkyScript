#include <yaml-cpp/yaml.h>

#include "SkyScript/Parsing/YAMLtoScriptNode.h"

namespace SkyScript::Parsing::YAML {
	ScriptNodeImpl YAMLtoScriptNode(std::string yamlText) {
		return ScriptNodeImpl();
	}
	ScriptNodeImpl YAMLNodeToScriptNode(const ::YAML::Node& yaml) {
		return ScriptNodeImpl();
	}
	ScriptNodeImpl YAMLMapToScriptNode(const ::YAML::Node& yaml) {
		return ScriptNodeImpl();
	}
	ScriptNodeImpl YAMLSequenceToScriptNode(const ::YAML::Node& yaml) {
		return ScriptNodeImpl();
	}
	ScriptNodeImpl YAMLValueToScriptNode(const ::YAML::Node& yaml) {
		return ScriptNodeImpl();
	}
	ScriptNodeImpl YAMLNullToScriptNode(const ::YAML::Node& yaml) {
		return ScriptNodeImpl();
	}
}

//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLMapToScriptNode(const ::YAML::Node& yaml) {
//	auto node = SkyScript::ScriptNodeImpl();
//	node.SetType(SkyScript::ScriptNodeType::MAP);
//
//	for (::YAML::const_iterator iterator = yaml.begin(); iterator != yaml.end(); ++iterator) {
//		auto key = iterator->first.Scalar();
//		auto value = iterator->second;
//		auto valueNode = SkyScript::Parsing::YAML::YAMLNodeToScriptNode(value);
//		node.AddMapNode(key, valueNode);
//	}
//
//	return node;
//}
//
//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLSequenceToScriptNode(const ::YAML::Node&) {
//	auto node = SkyScript::ScriptNodeImpl();
//	// TODO
//	return node;
//}
//
//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLValueToScriptNode(const ::YAML::Node&) {
//	auto node = SkyScript::ScriptNodeImpl();
//	// TODO
//	return node;
//}
//
//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLNullToScriptNode(const ::YAML::Node&) {
//	auto node = SkyScript::ScriptNodeImpl();
//	// TODO
//	return node;
//}
//
//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLNodeToScriptNode(const ::YAML::Node& yaml) {
//	auto type = yaml.Type();
//	switch (type) {
//	case ::YAML::NodeType::value::Map:
//		return YAMLMapToScriptNode(yaml);
//	case ::YAML::NodeType::value::Sequence:
//		return YAMLSequenceToScriptNode(yaml);
//	case ::YAML::NodeType::value::Scalar:
//		return YAMLValueToScriptNode(yaml);
//	case ::YAML::NodeType::value::Null:
//	case ::YAML::NodeType::value::Undefined:
//	default:
//		return YAMLNullToScriptNode(yaml);
//	}
//}
//
//SkyScript::ScriptNodeImpl SkyScript::Parsing::YAML::YAMLtoScriptNode(std::string yamlText) {
//	// return YAMLNodeToScriptNode(::YAML::Load(yamlText));
//	return SkyScript::ScriptNodeImpl();
//}
//
////void Test() {
////		SkyScript::Parsing::YAML::YAMLtoScriptNode("foo");
////}
