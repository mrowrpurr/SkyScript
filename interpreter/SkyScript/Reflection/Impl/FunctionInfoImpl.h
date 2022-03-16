#pragma once

#include <utility>

#include "SkyScript/Reflection/FunctionInfo.h"
#include "SkyScript/Reflection/Impl/FunctionParameterInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class FunctionInfoImpl : public SkyScript::Reflection::FunctionInfo {
        std::string _namespace;
        std::string _name;
        std::string _docString;
        std::string _returnTypeName = "void";
        bool _isNative = false;
        std::string _nativeFunctionName;
        std::vector<FunctionParameterInfoImpl> _parameters;
        std::vector<std::string> _parameterNames;
        std::unordered_map<std::string, size_t> _parameterNameLookup;

    public:
        FunctionInfoImpl() = default;
        FunctionInfoImpl(std::string functionNamespace, std::string functionName) :
            _namespace(std::move(functionNamespace)),
            _name(std::move(functionName)) {}
        FunctionInfoImpl(const FunctionInfoImpl& fn) {
            _namespace = fn._namespace;
            _name = fn._name;
            _docString = fn._docString;
            _returnTypeName = fn._returnTypeName;
            _isNative = fn._isNative;
            _nativeFunctionName = fn._nativeFunctionName;
            _parameters = fn._parameters;
            _parameterNames = fn._parameterNames;
            _parameterNameLookup = fn._parameterNameLookup;
        }

        std::string GetName() override { return _name; }
        std::string GetNamespace() override { return _namespace; }
        std::string GetFullName() override { return _namespace + "::" + _name; }
        std::string GetDocString() override { return _docString; }
        std::string GetReturnTypeName() override { return _returnTypeName; }
        bool IsNative() override { return _isNative; }
        std::string GetNativeFunctionName() override { return _nativeFunctionName; }

        bool HasParameters() override { return !_parameters.empty(); }
        size_t GetParameterCount() override { return _parameters.size(); }
        std::vector<std::string>& GetParameterNames() override { return _parameterNames; }
        bool HasParameterName(const std::string& name) override { return _parameterNameLookup.contains(name); }
        FunctionParameterInfo& GetParameter(int index) override {
            if (index >= 0 && index < _parameters.size()) {
                return _parameters[index];
            } else {
                throw FunctionParameterNotFound(GetName(), index);
            }
        }
        FunctionParameterInfo& GetParameter(const std::string& name) override {
            if (_parameterNameLookup.contains(name)) {
                return _parameters[_parameterNameLookup[name]];
            } else {
                throw FunctionParameterNotFound(GetName(), name);
            }
        }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetDocString(const std::string& docString) { _docString = docString; }
        void SetReturnTypeName(const std::string& typeName) { _returnTypeName = typeName; }
        void SetIsNative(bool isNative) { _isNative = isNative; }
        void SetNativeFunctionName(const std::string& functionName) { _nativeFunctionName = functionName; }
        void AddParameter(FunctionParameterInfoImpl parameterInfo) {
            size_t nextIndex = _parameters.size();
            _parameters.emplace_back(parameterInfo);
            _parameterNameLookup[parameterInfo.GetName()] = nextIndex;
        }
    };
}