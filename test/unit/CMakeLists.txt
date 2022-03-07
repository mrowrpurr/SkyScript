set(UNIT_TEST_SUITE_NAME "${PROJECT_NAME}UnitTests")

find_package(GTest CONFIG REQUIRED)

file(GLOB TESTS_SOURCE *.h *.cpp)

ADD_EXECUTABLE("${UNIT_TEST_SUITE_NAME}" ${TESTS_SOURCE})

target_compile_features(
		"${UNIT_TEST_SUITE_NAME}"
		PRIVATE
		cxx_std_23
)

find_package(GTest CONFIG REQUIRED)
target_link_libraries("${UNIT_TEST_SUITE_NAME}" "${PROJECT_NAME}" GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)

add_test(NAME "${UNIT_TEST_SUITE_NAME}" COMMAND "${UNIT_TEST_SUITE_NAME}")
