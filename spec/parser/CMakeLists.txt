add_executable(spec-parser ../specHelper.h main.cpp)

find_path(BANDIT_INCLUDE_DIRS "bandit/adapters.h")
target_include_directories(spec-parser PRIVATE ${BANDIT_INCLUDE_DIRS})

find_path(SNOWHOUSE_INCLUDE_DIRS "snowhouse/assert.h")
target_include_directories(spec-parser PRIVATE ${SNOWHOUSE_INCLUDE_DIRS})

add_test(NAME spec-parser-test COMMAND spec-parser --reporter=spec)
