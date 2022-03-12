add_executable(spec-interpreter ../specHelper.h main.cpp)

find_path(BANDIT_INCLUDE_DIRS "bandit/adapters.h")
target_include_directories(spec-interpreter PRIVATE ${BANDIT_INCLUDE_DIRS})

find_path(SNOWHOUSE_INCLUDE_DIRS "snowhouse/assert.h")
target_include_directories(spec-interpreter PRIVATE ${SNOWHOUSE_INCLUDE_DIRS})

add_test(NAME spec-interpreter-test COMMAND spec-interpreter --reporter=spec)
