#pragma once

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
		c4::yml::Tree _tree;

	public:
		explicit YamlReader(std::string yamlText) {
			_tree = ryml::parse(ryml::to_substr((yamlText)));
		}

		bool IsMap() override {
			return false;
		}

		NodeType GetType() override {
			return IDocumentNode::NodeType::FunctionInvocation;
		}

		std::string GetFunctionName() override {
			return "";
		}
	};
}
