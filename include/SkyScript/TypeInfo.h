#include <utility>

#pragma once

namespace SkyScript {
	/*
	 * Represents a class or type.
	 */
	class TypeInfo {

	private:
		const std::string _name;
		const std::string _namespace;

	public:
		explicit TypeInfo(std::string typeName) : _name(std::move(typeName)) { }
		explicit TypeInfo(std::string typeName, std::string typeNamespace) : _name(std::move(typeName)), _namespace(std::move(typeNamespace)) { }

		const std::string& GetName() {
			return _name;
		}

		const std::string& GetNamespace() {
			return _namespace;
		}
	};
}
