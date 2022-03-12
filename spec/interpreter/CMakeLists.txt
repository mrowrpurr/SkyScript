add_executable(spec-interpreter ../specHelper.h main.cpp)
include(specs)
setupSpecDependencies(spec-interpreter)
