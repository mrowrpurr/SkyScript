#pragma once

#include <format>
#include <iostream>

#include <yaml-cpp/yaml.h>

#include "Context.h"

namespace SkyScript::Evaluator {

	namespace {
		// https://stackoverflow.com/a/874160
		bool StringEndsWith(const std::string &fullString, const std::string &ending) {
			if (fullString.length() >= ending.length()) {
				return (0 == fullString.compare (fullString.length() - ending.length(), ending.length(), ending));
			} else {
				return false;
			}
		}

		std::string GetFunctionName(const std::string &fullString) {
			return fullString.substr(0, fullString.size() - 2);
		}

		void AddFunctionInfo(Context& context, const std::string &functionName, const YAML::Node& functionBody) {
			auto functionInfo = FunctionInfo();
			functionInfo.Name = functionName;
			functionInfo.Body = functionBody;
			context.FunctionInfos.emplace(functionName, functionInfo);
		}
	}

	Context Evaluate(Context &context, const std::string &yamlText) {
		auto node = YAML::Load(yamlText);

		// LAZY NONSENSE HERE! #ftw

		// Function definition:
		if (node.IsMap() && node.size() == 1) {
			auto keyName = node.begin()->first.Scalar();
			if (StringEndsWith(keyName, "()")) {
				auto functionName = GetFunctionName(keyName);
				AddFunctionInfo(context, functionName, node.begin()->second);
			} else {
				std::cout << std::format("{} is not a function", keyName);
			}
		} else {
			std::cout << std::format("Dunno what to do with this YAML {}", yamlText);
		}

		return context;
	}
}

//for (YAML::const_iterator iterator = node.begin(); iterator != node.end(); ++iterator) {
//}
