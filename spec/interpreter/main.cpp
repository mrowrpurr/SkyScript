#include "specHelper.h"

#include "ClassDefinitionSpec.h"
#include "ContextSpec.h"
#include "FunctionDefinitionSpec.h"
#include "NativeFunctionSpec.h"
#include "SyntaxErrorsSpec.h"
#include "TypedValueSpec.h"
#include "TypesSpec.h"
#include "VariablesSpec.h"

int main(int argc, char* argv[]) { return SpecHelper::runBandit(argc, argv); }
