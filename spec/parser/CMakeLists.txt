file(GLOB_RECURSE SKYSCRIPT_PARSER_SPECS *.cpp)
add_executable(spec-parser ../specHelper.h ${SKYSCRIPT_PARSER_SPECS})
target_include_directories(spec-parser PRIVATE ${SKYSCRIPT_ROOT_DIR}/parser)

include(yaml)
setupYamlDependencies(spec-parser PRIVATE)

include(specs)
setupSpecDependencies(spec-parser)
