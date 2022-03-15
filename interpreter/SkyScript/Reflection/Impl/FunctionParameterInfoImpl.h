#pragma once

#include <utility>

#include "SkyScript/SkyScriptNode.h"
#include "SkyScript/Reflection/FunctionParameterInfo.h"

namespace SkyScript::Reflection::Impl {
    class FunctionParameterInfoImpl : public FunctionParameterInfo {
        std::string _name;
        std::string _docString;
        std::string _typeName;
        SkyScriptNodeImpl _defaultExpression;

    public:
        std::string GetName() override { return _name; }
        std::string GetDocString() override { return _docString; }
        std::string GetTypeName() override { return _typeName; }
        SkyScriptNode& GetDefaultValueExpression() override { return _defaultExpression; }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetName(std::string name) { _name = std::move(name); }
        void SetDocString(std::string docString) { _docString = std::move(docString); }
        void SetTypeName(std::string typeName) { _typeName = std::move(typeName); }
        void SetDefaultExpression(const SkyScriptNodeImpl& node) { _defaultExpression = node; }
    };
}