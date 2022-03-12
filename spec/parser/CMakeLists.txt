add_executable(spec-parser ../specHelper.h main.cpp)
include(specs)
setupSpecDependencies(spec-parser)
