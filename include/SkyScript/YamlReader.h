#pragma once

#include <yaml-cpp/yaml.h>

#include "Context.h"
#include "IDocumentReader.h"

namespace SkyScript {

	/*
	 * Responsible for reading YAML scripts and type definitions
	 */
	class YamlReader : public IDocumentReader {
	private:
		YAML::Node _root;

	public:
		explicit YamlReader(std::string yamlText) {
			_root = YAML::Load(yamlText);
			std::cout << std::format("YAML TEXT: '{}'", yamlText);
			std::cout << std::format("IS MAP? {}", _root.IsMap());
			for(YAML::const_iterator node = _root.begin(); node != _root.end(); ++node) {
				std::cout << std::format("LINE: {} KEY: {} VALUE: {}", node->first.Mark().line, node->first.as<std::string>(), node->second.as<std::string>());
			}
		}

		bool IsMap() override {
			return false;
		}

		NodeType GetType() override {
			return IDocumentNode::NodeType::FunctionInvocation;
		}

		std::string GetFunctionName() override {
			return "TESTING!";
		}
	};
}
