#pragma once

#include <string>
#include <unordered_map>

namespace SkyScript {

	class NativeFunctionSet {
		std::unordered_map<std::string, std::string> _nativeFunctions;

		NativeFunctionSet() = default;

	public:
		NativeFunctionSet(NativeFunctionSet const &) = delete;
		NativeFunctionSet &operator=(NativeFunctionSet const &) = delete;

		static NativeFunctionSet &GetSingleton() {
			static NativeFunctionSet nativeFunctionSet;
			return nativeFunctionSet;
		}

		bool HasFunction(std::string functionName) {
			return _nativeFunctions.contains(functionName);
		}


	};
}