#pragma once

#include "TypeInfo.h"

namespace SkyScript {

	class TypeSet {
	private:
		std::unordered_map<std::string, TypeInfo> _typeInfos;

	public:
		size_t Count() {
			return _typeInfos.size();
		}

		bool HasType(std::string typeName) {
			return _typeInfos.contains(typeName);
		}
	};
}
