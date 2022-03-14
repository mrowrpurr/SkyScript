#pragma once

#include <format>
#include <utility>

namespace SkyScript::Parsers::Exceptions {
    class SkyScriptNodeSingleMapNotFound : public std::exception {
    public:
        SkyScriptNodeSingleMapNotFound(const std::string& textRepresentationOfNode) :
                std::exception(std::format("SkyScript node is not a single map '{}'", textRepresentationOfNode).c_str()) {}
    };
}