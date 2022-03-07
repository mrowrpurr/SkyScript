#pragma once

namespace SkyScript {

	/*
	 * Represents a context of a script. This may be a whole script or just a part of it.
	 * Each Context has a local variable table.
	 * Contexts can find variable by traversing their locals table and those of parent contexts.
	 * Most contexts have a parent (except top-level contexts, e.g. a main top-level script)
	 */
	class Context {
	private:
		std::unordered_map<std::string_view, std::string_view> _localVariables;

	public:
		std::unordered_map<std::string_view, std::string_view>& GetLocalVariables() {
			return _localVariables;
		}
	};
}