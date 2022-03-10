#pragma once

#include <format>

//#include <yaml-cpp/yaml.h>
#include <ryml/ryml_std.hpp>
#include <ryml/ryml.hpp>

#include "Context.h"
#include "IDocumentReader.h"

namespace SkyScript {

	/*
	 * Responsible for reading YAML scripts and type definitions
	 */
	class YamlReader : public IDocumentReader {
	private:
//		YAML::Node _root;
		c4::yml::Tree _tree;
		c4::yml::NodeRef _currentLocation;
		std::string _text;

	public:
		explicit YamlReader(std::string yamlText) {
			_text = yamlText;
			_tree = ryml::parse(ryml::to_substr(yamlText));
			_currentLocation = _tree.rootref();
		}

		bool IsMap() override {
//			return _root.IsMap();
			return _currentLocation.is_map();
		}

		bool IsSeq() override {
//			return _root.IsSequence();
			return _currentLocation.is_seq();
		}

		NodeType GetType() override {
			return IDocumentNode::NodeType::FunctionInvocation;
		}

		std::string GetFunctionName() override {
			return "TESTING!";
		}
	};
}
