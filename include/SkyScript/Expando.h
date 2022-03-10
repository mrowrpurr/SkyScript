#pragma once

namespace SkyScript {

	enum ExpandoType {
		MAP,
		SEQ
	};

	class Expando {
		ExpandoType _type;

	public:
		void SetType(ExpandoType type) { _type = type; }
		ExpandoType GetType() { return _type; }

		bool IsMap() { return _type == ExpandoType::MAP; }
		bool IsSeq() { return _type == ExpandoType::SEQ; }

		bool HasKey(std::string) {
			return true;
		}
	};
}
