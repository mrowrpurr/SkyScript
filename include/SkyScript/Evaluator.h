#pragma once

#include <yaml-cpp/yaml.h>

namespace SkyScript {

	/*
	 * Responsible for evaluating simple expressions, e.g. provided by YAML
	 * Expressions are evaluated in the context of a Context
	 */
	class Evaluator {
	public:
		void Evaluate(SkyScript::Context& context, const std::string& yamlText) {
			auto yaml = YAML::Load(yamlText);
			if (yaml.IsMap()) {
				for (YAML::const_iterator it = yaml.begin(); it != yaml.end(); ++it) {
					const auto key = it->first.as<std::string>();
					const auto value = it->first.as<std::string>();
					context.SetLocalVariable(key, value);
				}
			}
		}
	};
}