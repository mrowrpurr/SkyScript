#pragma once

#include <utility>

#include "FunctionInfo.h"
#include "FunctionSet.h"
#include "TypeInfo.h"
#include "TypeSet.h"

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
		FunctionSet _functions;

	public:
		// TODO accumulate total with parent contexts as well
		size_t GetTypeCount() {
			return _types.Count();
		}

		// TODO search parent contexts as well
		bool TypeExists(std::string typeName) {
			return _types.HasType(std::move(typeName));
		}

		// TODO search parent contexts as well
		bool FunctionExists(const std::string& functionName) {
			return _functions.HasFunction(functionName);
		}
	};
}