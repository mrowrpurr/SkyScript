#pragma once

#include <SkyScript/Interpreter/Reflection/FunctionInfoImpl.h>

using namespace SkyScript::Interpreter::Reflection;

namespace SkyScript::Interpreter {
    class ContextImpl {
        // Function storage
        std::atomic<int64_t> _functionIdCounter = 0;
        std::unordered_map<int64_t, FunctionInfoImpl> _functionsById;
        std::unordered_map<std::string, int64_t> _functionIdByName;
        std::unordered_map<std::string, int64_t> _functionIdByFullName;

    public:
        size_t FunctionCount() { return _functionsById.size(); }
        bool FunctionExists(const std::string& name) { return _functionIdByName.contains(name) || _functionIdByFullName.contains(name); }
        void AddFunction(FunctionInfoImpl info) {
            auto id = _functionIdCounter++;
            _functionsById.insert_or_assign(id, info);
            _functionIdByName.insert_or_assign(info.GetName(), id);
            _functionIdByFullName.insert_or_assign(info.GetFullName(), id);
        }
    };
}
