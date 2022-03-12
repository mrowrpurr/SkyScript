#pragma once

#include <unordered_map>

#include "ScriptNode.h"

namespace SkyScript {

	class ScriptNodeImpl : public ScriptNode {
		ScriptNodeType _type = ScriptNodeType::UNDEFINED;
		std::unordered_map<std::string, ScriptNodeImpl> _map;
		std::vector<ScriptNodeImpl> _vector;
		std::string _value;
		bool _isQuotedString = false;

	public:
		ScriptNodeImpl() = default;
		ScriptNodeImpl(const ScriptNodeImpl& node) {
			_type = node._type;
			_map = node._map;
			_vector = node._vector;
			_value = node._value;
			_isQuotedString = node._isQuotedString;
		}
		~ScriptNodeImpl() override = default;

		bool IsMap() override { return _type == ScriptNodeType::MAP; }
		bool IsVector() override { return _type == ScriptNodeType::VECTOR; }
		bool IsValue() override { return _type == ScriptNodeType::VALUE; }
		void SetType(ScriptNodeType type) { _type = type; }

		size_t Size() override {
			switch (_type) {
			case ScriptNodeType::MAP:
				return _map.size();
			case ScriptNodeType::VECTOR:
				return _vector.size();
			case ScriptNodeType::VALUE:
				return _value.size();
			default:
				return 0;
			}
		}

		void AddMapNode(std::string key, ScriptNodeImpl node) {
			_map.try_emplace(key, node);
		}
	};
}
