#pragma once

#include <unordered_map>

#include "SkyScriptNode.h"

namespace SkyScript {

	class SkyScriptNodeImpl : public SkyScriptNode {
		SkyScriptNodeType _type = SkyScriptNodeType::UNDEFINED;
		std::unordered_map<std::string, SkyScriptNodeImpl> _map;
		std::vector<SkyScriptNodeImpl> _vector;
		std::string _value;
		bool _isQuotedString = false;

	public:
		SkyScriptNodeImpl() = default;
		SkyScriptNodeImpl(const SkyScriptNodeImpl& node) {
			_type = node._type;
			_map = node._map;
			_vector = node._vector;
			_value = node._value;
			_isQuotedString = node._isQuotedString;
		}
		~SkyScriptNodeImpl() override = default;

		bool IsMap() override { return _type == SkyScriptNodeType::MAP; }
		bool IsArray() override { return _type == SkyScriptNodeType::ARRAY; }
		bool IsValue() override { return _type == SkyScriptNodeType::VALUE; }
		void SetType(SkyScriptNodeType type) { _type = type; }
        const std::string& GetStringValue() override { return _value; }
        bool ContainsKey(const std::string& key) override { return _map.contains(key); }
        SkyScriptNode& operator [] (const std::string& key) override { return _map[key]; }
        SkyScriptNode& operator [] (int index) override { return _vector[index]; }

		size_t Size() override {
			switch (_type) {
			case SkyScriptNodeType::MAP:
				return _map.size();
			case SkyScriptNodeType::ARRAY:
				return _vector.size();
			case SkyScriptNodeType::VALUE:
				return _value.size();
			default:
				return 0;
			}
		}

        ///////////////////////////////////////////////
        // Private Non-Virtual Override Functions Below
        ///////////////////////////////////////////////

		void AddMapNode(const std::string& key, SkyScriptNodeImpl node) { _map.try_emplace(key, node); }
        void AddArrayNode(const SkyScriptNodeImpl& node) { _vector.emplace_back(node); }
        void SetStringValue(const std::string& value) { _value = value; }
    };
}