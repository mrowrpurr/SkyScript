file(GLOB SRCS *.cpp)

ADD_EXECUTABLE(SkyScriptTests ${SRCS})

target_compile_features(
	SkyScriptTests
	PRIVATE
		cxx_std_23
)

target_link_libraries(SkyScriptTests SkyScript GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)

add_test(NAME SkyScriptTests COMMAND SkyScriptTests)
