file(GLOB SRCS *.cpp)

ADD_EXECUTABLE(SkyScriptTests ${SRCS})

target_link_libraries(SkyScriptTests PRIVATE GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)

add_test(NAME SkyScriptTests COMMAND SkyScriptTests)
