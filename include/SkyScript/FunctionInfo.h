#pragma once

#include <string>
#include <yaml-cpp/yaml.h>

namespace SkyScript {

	class FunctionInfo {
	public:
		std::string Name;
		YAML::Node Body;
	};
}
