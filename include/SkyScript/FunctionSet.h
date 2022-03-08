#pragma once

#include "FunctionInfo.h"

namespace SkyScript {

	class FunctionSet {
	private:
		std::unordered_map<std::string, FunctionInfo> _functions;

	public:
		bool HasFunction(const std::string& functionName) {
			return _functions.contains(functionName);
		}
	};
}
