#include <iostream>
#include <format>
#include <vector>
#include <filesystem>
#include <fstream>
#include <SkyScript/Parsers/YAML.h>
#include <SkyScript/Interpreter/Evaluate.h>
#include <SkyScript/Reflection/Impl/ContextImpl.h>

namespace fs = std::filesystem;

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

int main(int argc, char* argv[]) {
    std::vector<std::string> arguments(argv + 1, argv + argc);
    for (const auto& arg : arguments) {
        if (fs::exists(arg)) {
            auto path = fs::path(arg);
            auto ext = path.extension();
            if (ext == ".yaml" || ext == ".yml") {
                auto yaml = ReadTextFile(arg);
                auto scriptNode = SkyScript::Parsers::YAML::Parse(yaml);
                auto context = SkyScript::Reflection::Impl::ContextImpl();
                SkyScript::Interpreter::Evaluate(scriptNode, context);
            } else if (ext == ".json") {
                std::cout << ".json files are not currently supported";
            } else {
                std::cout << std::format("Unsupported file extension {}", ext.string());
            }
        } else {
            std::cout << std::format("Script not found: {}", arg);
        }
    }
}
