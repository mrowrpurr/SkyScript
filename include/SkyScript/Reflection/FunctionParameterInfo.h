#pragma once

#include <string>
#include <yaml-cpp/yaml.h>

namespace SkyScript {

	class FunctionParameterInfo {
	public:
		std::string Name;
		std::string DocString;
		std::string Type;
	};
}
