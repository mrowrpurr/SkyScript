#pragma once

#include <format>

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
		std::string _text;

	public:
		explicit YamlReader(std::string yamlText) {
			_text = yamlText;
			_root = YAML::Load(yamlText);
		}

		bool IsMap() override {
			return _root.IsMap();
		}

		bool IsSeq() override {
			return _root.IsSequence();
		}

		NodeType GetType() override {
			return IDocumentNode::NodeType::FunctionInvocation;
		}

		std::string GetFunctionName() override {
			return "TESTING!";
		}
	};
}
