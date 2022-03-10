#pragma once

#include "IDocumentReader.h"
#include "Expando.h"

namespace SkyScript::ExpandoDocumentReader {

	void ReadDocumentIntoExpando(Expando& expando, IDocumentReader& document) {
//		if (document.IsMap()) {
//
//		} else if (document.IsSeq()) {
//
//		}
	}

	Expando ReadDocument(IDocumentReader& document) {
		auto expando = Expando();
		ReadDocumentIntoExpando(expando, document);
		return expando;
	}
}
