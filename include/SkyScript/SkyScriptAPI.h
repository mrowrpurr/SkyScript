#pragma once

#include <string_view>
#include <functional>

namespace SkyScript::SkyScriptAPI {

	/*
	 *
	 */
	 __declspec(dllexport) void RegisterNativeFunction(std::string_view functionName, std::function<void()>&& handler);

}
