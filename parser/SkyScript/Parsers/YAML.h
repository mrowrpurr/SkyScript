#pragma once

#include <yaml-cpp/yaml.h>

#include "SkyScript/SkyScriptNodeImpl.h"

namespace SkyScript::Parsers::YAML {

    SkyScriptNodeImpl YAMLNodeToSkyScriptNode(const ::YAML::Node& yaml) {
        auto node = SkyScript::SkyScriptNodeImpl();
        auto type = yaml.Type();
        switch (type) {
            case ::YAML::NodeType::value::Map:
                node.SetType(SkyScript::SkyScriptNodeType::MAP);
                for (::YAML::const_iterator iterator = yaml.begin(); iterator != yaml.end(); ++iterator) {
                    auto key = iterator->first.Scalar();
                    auto value = iterator->second;
                    auto valueNode = YAMLNodeToSkyScriptNode(value);
                    node.AddMapNode(key, valueNode);
                }
        }
        return node;
    }

    SkyScriptNodeImpl Parse(const std::string& yamlText) {
         return YAMLNodeToSkyScriptNode(::YAML::Load(yamlText));
    }
}
