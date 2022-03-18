#pragma once

#include "SkyScript/Reflection/MethodInfo.h"
#include "SkyScript/Reflection/Impl/MemberInfoImpl.h"
#include "SkyScript/Reflection/Impl/FunctionInfoImpl.h"

namespace SkyScript::Reflection::Impl {

    class MethodInfoImpl : public MethodInfo, public MemberInfoImpl, public FunctionInfoImpl {
    public:
        MethodInfoImpl() = default;

        // MemberInfo
        std::string GetName() override { return MemberInfoImpl::GetName(); }
        std::string GetDocString() override { return MemberInfoImpl::GetDocString(); }
        std::string GetTypeName() override { return MemberInfoImpl::GetTypeName(); }

        // FunctionInfo
        std::string GetNamespace() override { return FunctionInfoImpl::GetNamespace(); }
        std::string GetFullName() override { return FunctionInfoImpl::GetFullName(); }
        std::string GetReturnTypeName() override { return FunctionInfoImpl::GetReturnTypeName(); } // <--- TODO merge with GetTypeName()
        bool IsNative() override { return FunctionInfoImpl::IsNative(); }
        std::string GetNativeFunctionName() override { return FunctionInfoImpl::GetNativeFunctionName(); }
        bool HasParameters() override { return FunctionInfoImpl::HasParameters(); }
        size_t GetParameterCount() override { return FunctionInfoImpl::GetParameterCount(); }
        std::vector<std::string>& GetParameterNames() override { return FunctionInfoImpl::GetParameterNames(); }
        bool HasParameterName(const std::string& name) override { return FunctionInfoImpl::HasParameterName(name); }
        FunctionParameterInfo& GetParameter(int index) override { return FunctionInfoImpl::GetParameter(index); }
        FunctionParameterInfo& GetParameter(const std::string& name) override { return FunctionInfoImpl::GetParameter(name); }
        bool UsesCustomParameters() override { return FunctionInfoImpl::UsesCustomParameters(); }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

    };
}
