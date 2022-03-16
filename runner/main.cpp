#include <iostream>
#include <format>
#include <vector>
#include <filesystem>
#include <fstream>
#include <spdlog/spdlog.h>
#include <SkyScript/Parsers/YAML.h>
#include <SkyScript/Interpreter/Evaluate.h>
#include <SkyScript/Interpreter/NativeFunctions.h>
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
//    spdlog::set_level(spdlog::level::off);

    std::string importDefinitionFilePath = "../../../../examples/import.yaml";
    std::string printDefinitionFilePath = "../../../../examples/print.yaml";
    std::string helloDefinitionFilePath = "../../../../examples/hello.yaml";

    if (fs::exists("./examples")) {
        importDefinitionFilePath = "examples/import.yaml";
        printDefinitionFilePath = "examples/print.yaml";
        helloDefinitionFilePath = "examples/hello.yaml";
    }

    // Register a print function!
    auto printFunction = [](FunctionInvocationParams& params){
        std::cout << params.Text("text") + "\n";
        return FunctionInvocationResponse::ReturnVoid();
    };

    // Register an import function!
    auto importFunction = [](FunctionInvocationParams& params){
        for (const auto& paramName : params.Names()) {
            auto path = params.Text(paramName);
            if (fs::exists(path)) {
                auto yaml = ReadTextFile(path);
                auto scriptNode = SkyScript::Parsers::YAML::Parse(yaml);
                auto* context = (ContextImpl*) &params.Context();
                std::cout << std::format("import {}\n", path);
                SkyScript::Interpreter::Evaluate(scriptNode, *context);
            } else {
                std::cout << std::format("Import not found {}\n", path);
            }
        }
        return FunctionInvocationResponse::ReturnVoid();
    };

    SkyScript::Interpreter::NativeFunctions::GetSingleton().RegisterFunction("stdlib::print", printFunction);
    SkyScript::Interpreter::NativeFunctions::GetSingleton().RegisterFunction("stdlib::import", importFunction);

    auto context = SkyScript::Reflection::Impl::ContextImpl();

    auto importScriptNode = SkyScript::Parsers::YAML::Parse(ReadTextFile(importDefinitionFilePath));
    auto printScriptNode = SkyScript::Parsers::YAML::Parse(ReadTextFile(printDefinitionFilePath));

    SkyScript::Interpreter::Evaluate(importScriptNode, context);
    SkyScript::Interpreter::Evaluate(printScriptNode, context);

    std::vector<std::string> arguments(argv + 1, argv + argc);
    for (const auto& arg : arguments) {
        if (fs::exists(arg)) {
            auto path = fs::path(arg);
            auto ext = path.extension();
            if (ext == ".yaml" || ext == ".yml") {
                auto yaml = ReadTextFile(arg);
                auto scriptNode = SkyScript::Parsers::YAML::Parse(yaml);
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

    if (arguments.empty()) {
        auto yaml = ReadTextFile(helloDefinitionFilePath);
        auto scriptNode = SkyScript::Parsers::YAML::Parse(yaml);
        SkyScript::Interpreter::Evaluate(scriptNode, context);
    }
}
