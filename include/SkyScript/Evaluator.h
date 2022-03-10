#pragma once

#include <format>

#include "Context.h"

/*
 * Responsible for evaluating simple expressions, e.g. provided by YAML
 * Expressions are evaluated in the context of a Context
 */
namespace SkyScript::Evaluator {

	void InvokeFunction(Context& context, const std::string& functionName) {
//		if (context.FunctionExists(functionName)) {
//			std::cout << std::format("FUNCTION EXISTS {}", functionName);
//		} else {
//			// Nothing ...
//			std::cout << std::format("FUNCTION *does not* EXIST {}", functionName);
//		}
	}

	Context Evaluate(Context context, const std::string& yamlText) {
//		auto reader = YamlReader(yamlText);
//		Evaluate(context, reader);
		return context;
	}
}