#pragma once

#include <utility>
#include <unordered_map>

#include "Reflection/FunctionInfo.h"
#include "Reflection/TypeInfo.h"

namespace SkyScript {

	class Context {
	public:
		std::unordered_map<std::string, FunctionInfo> FunctionInfos;
		std::unordered_map<std::string, TypeInfo> TypeInfos;
	};
}