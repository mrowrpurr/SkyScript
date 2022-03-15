#include "specHelper.h"

#include "ContextSpec.h"
#include "FunctionDefinitionSpec.h"
#include "NativeFunctionSpec.h"
#include "PapyrusFunctionSpec.h"
#include "SyntaxErrorsSpec.h"
#include "TypedValueSpec.h"
#include "TypesSpec.h"
#include "VariablesSpec.h"
#include "functions/ClassSpec.h"
#include "functions/ImportSpec.h"
#include "functions/TestLogSpec.h"

int main(int argc, char* argv[]) { return SpecHelper::runBandit(argc, argv); }
