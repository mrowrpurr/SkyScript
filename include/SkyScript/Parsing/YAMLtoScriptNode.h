#pragma once

#include <yaml-cpp/yaml.h>

#include "../ScriptNodeImpl.h"

namespace SkyScript::Parsing::YAML {
	ScriptNodeImpl YAMLtoScriptNode(std::string yamlText);
	ScriptNodeImpl YAMLNodeToScriptNode(const ::YAML::Node& yaml);
	ScriptNodeImpl YAMLMapToScriptNode(const ::YAML::Node& yaml);
	ScriptNodeImpl YAMLSequenceToScriptNode(const ::YAML::Node& yaml);
	ScriptNodeImpl YAMLValueToScriptNode(const ::YAML::Node& yaml);
	ScriptNodeImpl YAMLNullToScriptNode(const ::YAML::Node& yaml);
}
