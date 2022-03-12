#pragma once

namespace SkyScript {
    enum SkyScriptNodeType { MAP, VECTOR, VALUE, UNDEFINED };

    class SkyScriptNode {
    public:
        virtual ~SkyScriptNode() = default;
        virtual bool IsMap() = 0;
        virtual bool IsVector() = 0;
        virtual bool IsValue() = 0;
        virtual size_t Size() = 0;
    };
}
