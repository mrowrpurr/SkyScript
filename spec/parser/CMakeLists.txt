# Meh. Just include the whole damn parser.
#file(GLOB_RECURSE SKYSCRIPT_PARSER_SOURCE ${SKYSCRIPT_ROOT_DIR}/parser/*.h)
#file(GLOB_RECURSE SKYSCRIPT_PARSER_SPECS *.cpp)

add_executable(spec-parser
        ../specHelper.h
        ParserSpec.cpp
        ${SKYSCRIPT_ROOT_DIR}/parser/SkyScript/SkyScriptNode.h
        ${SKYSCRIPT_ROOT_DIR}/parser/SkyScript/SkyScriptNodeImpl.h
        ${SKYSCRIPT_ROOT_DIR}/parser/SkyScript/Parsers/YAML.h
)
#add_executable(spec-parser ../specHelper.h ${SKYSCRIPT_PARSER_SOURCE} ${SKYSCRIPT_PARSER_SPECS})
target_include_directories(spec-parser PRIVATE ${SKYSCRIPT_ROOT_DIR}/parser)

include(yaml)
setupYamlDependencies(spec-parser PRIVATE)

include(specs)
setupSpecDependencies(spec-parser)
