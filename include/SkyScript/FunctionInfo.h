#pragma once

#include <string>

namespace SkyScript {
	/*
	 * Represents a function declared on a class or in a context.
	 */
	class FunctionInfo {

	private:
		const std::string _name;

	public:
		explicit FunctionInfo(std::string functionName) : _name(std::move(functionName)) { }

		const std::string& GetName() {
			return _name;
		}
	};
}
