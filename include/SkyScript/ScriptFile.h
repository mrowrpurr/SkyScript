#pragma once

#include <filesystem>
#include <fstream>
#include <string>
#include <string_view>

namespace fs = std::filesystem;

namespace SkyScript::ScriptFile {

	// https://stackoverflow.com/a/40903508
	std::string ReadTextFile(const fs::path& path) {
		// Open the stream to 'lock' the file.
		std::ifstream f(path, std::ios::in | std::ios::binary);

		// Obtain the size of the file.
		const auto sz = fs::file_size(path);

		// Create a buffer.
		std::string result(sz, '\0');

		// Read the whole file into the buffer.
		f.read(result.data(), sz);

		return result;
	}

	std::string GetFileText(std::string filePath) {
		const auto path = fs::path(filePath);
		return ReadTextFile(path);
	}
}
