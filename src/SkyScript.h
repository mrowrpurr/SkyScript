#include <filesystem>
#include <format>

namespace fs = std::filesystem;

namespace SkyScript {
    class Whatever {
        public:
            std::string ReturnSomethingFromSomewhere() {
                auto path = fs::current_path();
                return std::format(
                    "Hello from SkyScript's C++ library. You are currently in folder {}",
                    path.string()
                );
            }
    };
}
