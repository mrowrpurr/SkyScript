#pragma once

namespace SkyScript {
	class IDocumentNode {
	public:
		enum NodeType {
			FunctionInvocation
		};

		virtual bool IsMap() = 0;
		virtual bool IsSeq() = 0;

		virtual NodeType GetType() = 0;
		virtual std::string GetFunctionName() = 0;
	};
}
