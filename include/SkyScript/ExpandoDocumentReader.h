#pragma once

#include "IDocumentReader.h"
#include "Expando.h"

namespace SkyScript::ExpandoDocumentReader {

	void ReadDocumentNodeIntoExpando(Expando& expando, IDocumentNode* node) {
		if (node->IsMap()) {
			expando.SetType(ExpandoType::MAP);
		} else if (node->IsSeq()) {
			expando.SetType(ExpandoType::SEQ);
		}
	}

	void ReadDocumentIntoExpando(Expando& expando, IDocumentReader& document) {
		auto node = (IDocumentNode*) &document;
		ReadDocumentNodeIntoExpando(expando, node);
	}

	Expando ReadDocument(IDocumentReader& document) {
		auto expando = Expando();
		ReadDocumentIntoExpando(expando, document);
		return expando;
	}
}
