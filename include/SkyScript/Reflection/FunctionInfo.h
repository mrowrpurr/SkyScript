#pragma once

#include <string>

#include "../ScriptNodeImpl.h"

namespace SkyScript {

	class FunctionInfo {
		std::string _name;
		std::string _docString;
		std::string _textExpression;
		ScriptNodeImpl _documentExpression;

	public:
		std::string GetName() { return _name; }
		std::string GetDocString() { return _docString; }
		std::string GetTextExpression() { return _textExpression; }
		ScriptNode& GetDocumentExpression() { return _documentExpression; }
	};
}
