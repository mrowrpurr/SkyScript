#include "SkyUnit.h"
#include <snowhouse/snowhouse.h>

using namespace snowhouse;

namespace SpellsTests {

    // Example functions to tes
    bool SpellExistsWithName(std::string_view spellName) {
         const auto dataHandler = RE::TESDataHandler::GetSingleton();
		 const auto& spells = dataHandler->GetFormArray<RE::SpellItem>();
		 for (const auto& spell : spells) {
			 if (std::string(spell->GetName()).find(spellName) != std::string::npos) {
				 return true;
			 }
		 }
		 return false;
    }

    // Examples tests
    void Run() {
        
        SkyUnit::AddTest("Cabbagify Spell exists", [](){
			AssertThat(SpellExistsWithName("Cabbagify"), IsTrue());
        });

    }
}