#include <filesystem>
#include <format>
#include <fstream>
#include <ryml/ryml.hpp>

namespace fs = std::filesystem;

namespace SkyScript {
    class Whatever {
        public:
            std::string ReturnSomethingFromSomewhere() {
                auto skyscriptExamples = fs::path("C:\\Users\\mrowr\\Dropbox\\Skyrim\\Mod Authoring\\Mods\\SkyScript Examples");
                auto scriptPath = skyscriptExamples.append("script.yaml");
                return std::format(
                    "Hi from SkyScript's C++ library. YAML file: {}\nExists: {}\nContent: {}",
                    scriptPath.string(),
                    fs::exists(scriptPath),
                    ReadFromFile(scriptPath.string())
                );
            }

            std::string ReadFromFile(std::string relativePath) {
                std::ifstream fileStream(relativePath.c_str());
                std::ostringstream stringStream;
                stringStream << fileStream.rdbuf();
                return stringStream.str();
            }

            std::string AllYamlArrays(std::string yamlText) {
                // auto tree = ryml::parse_in_place(yamlText.c_str());



                return "todo";
            }
    };
}
