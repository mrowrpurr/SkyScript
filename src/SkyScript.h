#include <filesystem>
#include <format>
#include <fstream>

namespace fs = std::filesystem;

namespace SkyScript {
    class Whatever {
        public:
            std::string ReturnSomethingFromSomewhere() {
                auto scriptPath = fs::current_path().append("Data").append("script.yaml");
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
    };
}
