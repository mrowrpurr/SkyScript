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
