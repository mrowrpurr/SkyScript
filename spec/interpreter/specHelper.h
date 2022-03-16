#pragma once

#include "../specHelper.h"

#include <SkyScript/SkyScriptNode.h>
#include <SkyScript/Parsers/YAML.h>
#include <SkyScript/Interpreter/Evaluate.h>
#include <SkyScript/Reflection/FunctionInfo.h>
#include <SkyScript/Reflection/Impl/ContextImpl.h>
#include <SkyScript/Reflection/Impl/FunctionInfoImpl.h>

using namespace SkyScript::Interpreter;
using namespace SkyScript::Reflection;
using namespace SkyScript::Reflection::Impl;

SkyScript::SkyScriptNodeImpl Eval(ContextImpl& context, const std::string& yamlText) {
    auto scriptNode = SkyScript::Parsers::YAML::Parse(yamlText);
    SkyScript::Interpreter::Evaluate(scriptNode, context);
    return scriptNode;
}

ContextImpl Eval(const std::string& yamlText) {
    auto context = ContextImpl();
    Eval(context, yamlText);
    return context;
}
