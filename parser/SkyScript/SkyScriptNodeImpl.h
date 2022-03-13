#pragma once

#include <regex>
#include <unordered_map>

#include "SkyScriptNode.h"

namespace SkyScript {

	class SkyScriptNodeImpl : public SkyScriptNode {
		SkyScriptNodeType _type = SkyScriptNodeType::UNDEFINED;
        SkyScriptNodeValueType _valueType = SkyScriptNodeValueType::STRING;
		std::unordered_map<std::string, SkyScriptNodeImpl> _map;
		std::vector<SkyScriptNodeImpl> _vector;
		std::string _stringValue;

	public:
		SkyScriptNodeImpl() = default;
		SkyScriptNodeImpl(const SkyScriptNodeImpl& node) {
			_type = node._type;
            _valueType = node._valueType;
			_map = node._map;
			_vector = node._vector;
			_stringValue = node._stringValue;
		}
		~SkyScriptNodeImpl() override = default;

		bool IsMap() override { return _type == SkyScriptNodeType::MAP; }
		bool IsArray() override { return _type == SkyScriptNodeType::ARRAY; }
		bool IsValue() override { return _type == SkyScriptNodeType::VALUE; }
        bool IsString() override { return _valueType == SkyScriptNodeValueType::STRING; }
        bool IsBool() override { return _valueType == SkyScriptNodeValueType::BOOL; }
        bool IsInteger() override { return _valueType == SkyScriptNodeValueType::INT; }
        bool IsFloat() override { return _valueType == SkyScriptNodeValueType::FLOAT; }
        const std::string& GetStringValue() override { return _stringValue; }
        bool ContainsKey(const std::string& key) override { return _map.contains(key); }
        SkyScriptNode& operator [] (const std::string& key) override { return _map[key]; }
        SkyScriptNode& operator [] (int index) override { return _vector[index]; }
        SkyScriptNode& Get(const std::string& key) override { return _map[key]; }
        SkyScriptNode& Get(int index) override { return _vector[index]; }

		size_t Size() override {
			switch (_type) {
			case SkyScriptNodeType::MAP:
				return _map.size();
			case SkyScriptNodeType::ARRAY:
				return _vector.size();
			case SkyScriptNodeType::VALUE:
				return _stringValue.size();
			default:
				return 0;
			}
		}

        std::string toString() override {
            std::string out{};
            if (IsMap()) {
                for (const auto& key : GetKeys()) {
                    auto value = _map[key];
                    out += std::format("{}: {}\n", key, value.toString());
                }
            } else if (IsArray()) {
                for (int i = 0; i < Size(); i++) {
                    auto value = _vector[i];
                    out += std::format("- {}\n", value.toString());
                }
            } else if (IsValue()) {
                out += _stringValue;
            }
            return out;
        }

        std::string GetSingleKey() override {
            if (IsMap() && Size() == 1) {
                return _map.begin()->first;
            } else {
                return "";
            }
        }

        // Hack until making a custom iterator
        std::vector<std::string> GetKeys() override {
            std::vector<std::string> keys{};
            for (const auto& [key, value] : _map) {
                keys.emplace_back(key);
            }
            return keys;
        }

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

        void SetType(SkyScriptNodeType type) { _type = type; }
		void AddMapNode(const std::string& key, SkyScriptNodeImpl node) { _map.try_emplace(key, node); }
        void AddArrayNode(const SkyScriptNodeImpl& node) { _vector.emplace_back(node); }
        void SetValue(const std::string& value, bool isQuotedString = false) {
            _stringValue = value;
            if (! isQuotedString)
                _valueType = DetermineScalarValue();


            auto x = _map.begin();
        }
        SkyScriptNodeValueType DetermineScalarValue() {
            if (_stringValue == "true" || _stringValue == "false") {
                return SkyScriptNodeValueType::BOOL;
            } else if (regex_match(_stringValue, std::regex("^[-]?[0-9]+$"))) {
                return SkyScriptNodeValueType::INT;
            } else if (regex_match(_stringValue, std::regex("^[-]?[0-9]+[.][0-9]+$"))) {
                return SkyScriptNodeValueType::FLOAT;
            }
            return SkyScriptNodeValueType::STRING;
        }
    };

    std::ostream& operator << (std::ostream &os, SkyScriptNode &node) {
        return (os << node.toString());
    }
}