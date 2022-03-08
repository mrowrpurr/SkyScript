#pragma once

#include <utility>

#include "TypeSet.h"
#include "TypeInfo.h"

namespace SkyScript {

	/*
	 * Represents a context of a script. This may be a whole script or just a part of it.
	 * Each Context has a local variable table.
	 * Contexts can find variable by traversing their locals table and those of parent contexts.
	 * Most contexts have a parent (except top-level contexts, e.g. a main top-level script)
	 */
	class Context {
	private:
		TypeSet _types;

	public:
		size_t GetTypeCount() {
			return _types.Count();
		}

		bool TypeExists(std::string typeName) {
			return _types.HasType(std::move(typeName));
		}

		bool FunctionExists(const std::string& functionName) {
			return false;
		}
	};
}