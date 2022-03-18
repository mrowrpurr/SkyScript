#pragma once

#include "SkyScript/NativeFunctions.h"

namespace SkyScript::Interpreter::Functions::Class {

    namespace {
        bool IsTypeDefinition(SkyScriptNode& def) {
            return def.ContainsKey(":name") || def.ContainsKey(":name:");
        }
        std::string GetTypeName(SkyScriptNode& def) {
            if (def.ContainsKey(":name")) {
                return def[":name"].GetStringValue();
            } else if (def.ContainsKey(":name:")) {
                return def[":name:"].GetStringValue();
            } else {
                return "";
            }
        }
        std::string GetTypeNamespace(SkyScriptNode&) {
            return "";
        }
    }

    FunctionInvocationResponse Fn(FunctionInvocationParams& params) {
        auto& def = params.Expression().GetSingleValue();
        if (IsTypeDefinition((def))) {
            auto* context = (ContextImpl*) &params.Context();
            auto typeName = GetTypeName(def);
            auto typeNamespace = GetTypeNamespace(def);
            auto type = TypeImpl(typeNamespace, typeName);

            context->AddType(type);
        }
        return FunctionInvocationResponse::ReturnVoid();
    }

    void Register() {
        NativeFunctions::GetSingleton().RegisterFunction("stdlib::class", Fn);
    }
}
