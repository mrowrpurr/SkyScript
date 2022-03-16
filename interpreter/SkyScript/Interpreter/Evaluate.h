#pragma once

#include <SkyScript/SkyScriptNode.h>

#include "SkyScript/Interpreter/Util.h"
#include "SkyScript/Interpreter/FunctionInvocation.h"
#include "SkyScript/Interpreter/FunctionParser.h"
#include "SkyScript/Reflection/Impl/ContextImpl.h"

namespace SkyScript::Interpreter {

    namespace {
        bool IsFunctionDefinition(SkyScriptNode& node) {
            return node.IsMap() && node.Size() == 1 && node.GetSingleKey().ends_with("()");
        }

        // TODO
        bool IsVariableDeclarationOrAssignment(SkyScriptNode& node) {
            auto key = node.GetSingleKey();
            return key.find("()") == std::string::npos && key.find("=") == std::string::npos;
        }

        bool EvaluateMap(SkyScriptNode& node, ContextImpl& context) {
            if (IsFunctionDefinition(node)) {
                SkyScript::Interpreter::FunctionParser::AddFunctionToContext(node, context);
            } else if (node.IsSingleKeyMap()) {
                SkyScript::Interpreter::FunctionInvocation::InvokeFunction(node, context);
            } else {
                context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", node.toString()));
                return false;
            }
            return true;
        }

        bool EvaluateArray(SkyScriptNode& node, ContextImpl& context) {
            for (int i = 0; i < node.Size(); i++) {
                spdlog::info("Eval Array Elem {} '{}'", i, node.toString());
                auto& child = node[i];
                if (child.IsMap()) {
                    EvaluateMap(child, context);
                } else if (child.IsArray()) {
                    EvaluateArray(child, context);
                } else {
                    context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", child.toString()));
                    return false;
                }
            }
            return true;
        }
    }

    bool Evaluate(SkyScriptNode& node, ContextImpl& context) {
        spdlog::info("EVALUATE '{}'", node.toString());
        if (node.IsMap()) {
            return EvaluateMap(node, context);
        } else if (node.IsArray()) {
            return EvaluateArray(node, context);
        } else {
            context.SetErrorMessage(std::format("Unknown SkyScript Syntax '{}'", node.toString()));
            return false;
        }
    }
}
