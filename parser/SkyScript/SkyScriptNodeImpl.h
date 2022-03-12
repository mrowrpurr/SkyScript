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

		bool IsMap() override { return true; } // return _type == SkyScriptNodeType::MAP; }
		bool IsVector() override { return _type == SkyScriptNodeType::VECTOR; }
		bool IsValue() override { return _type == SkyScriptNodeType::VALUE; }
		void SetType(SkyScriptNodeType type) { _type = type; }

		size_t Size() override {
			switch (_type) {
			case SkyScriptNodeType::MAP:
				return _map.size();
			case SkyScriptNodeType::VECTOR:
				return _vector.size();
			case SkyScriptNodeType::VALUE:
				return _value.size();
			default:
				return 0;
			}
		}

		void AddMapNode(const std::string& key, SkyScriptNodeImpl node) {
			_map.try_emplace(key, node);
		}
	};
}