#pragma once

namespace SkyScript {

	enum ScriptNodeType { MAP, VECTOR, VALUE, UNDEFINED };

	class ScriptNode {
	public:
		virtual ~ScriptNode() = default;
		virtual bool IsMap() = 0;
		virtual bool IsVector() = 0;
		virtual bool IsValue() = 0;
		virtual size_t Size() = 0;
	};
}
