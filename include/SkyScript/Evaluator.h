#pragma once

#include <format>

#include "Context.h"
#include "IDocumentReader.h"
#include "IDocumentNode.h"
#include "YamlReader.h"

/*
 * Responsible for evaluating simple expressions, e.g. provided by YAML
 * Expressions are evaluated in the context of a Context
 */
namespace SkyScript::Evaluator {

	void InvokeFunction(Context& context, const std::string& functionName) {
		if (context.FunctionExists(functionName)) {
			std::cout << std::format("FUNCTION EXISTS {}", functionName);
		} else {
			// Nothing ...
			std::cout << std::format("FUNCTION *does not* EXIST {}", functionName);
		}
	}

	void Evaluate(Context& context, IDocumentNode* node) {
//		switch (node->GetType()) {
//		case IDocumentNode::NodeType::FunctionInvocation:
//			InvokeFunction(context, node->GetFunctionName());
//			break;
//		default:
//			// Nothing ...
//			break;
//		}
	}

	void Evaluate(Context& context, IDocumentReader& reader) {
		auto node = (IDocumentNode*) &reader;
		Evaluate(context, node);
	}

	Context EvaluateYAML(Context context, const std::string& yamlText) {
		auto reader = YamlReader(yamlText);
		Evaluate(context, reader);
		return context;
	}

	Context EvaluateYAMLtoNewContext(const std::string& yamlText) {
		auto context = Context();
		EvaluateYAML(context, yamlText);
		return context;
	}
}