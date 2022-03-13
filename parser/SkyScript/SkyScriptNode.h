#pragma once

namespace SkyScript {
    enum SkyScriptNodeType { MAP, ARRAY, VALUE, UNDEFINED };

    class SkyScriptNode {
    public:
        virtual ~SkyScriptNode() = default;
        virtual bool IsMap() = 0;
        virtual bool IsArray() = 0;
        virtual bool IsValue() = 0;
        virtual size_t Size() = 0;
        virtual const std::string& GetStringValue() = 0;
        virtual bool ContainsKey(const std::string& key) = 0;
        virtual SkyScriptNode& operator [] (const std::string& key) = 0;
        virtual SkyScriptNode& operator [] (int index) = 0;
    };
}
