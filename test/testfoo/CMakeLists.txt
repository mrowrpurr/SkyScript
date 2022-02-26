file(GLOB SRCS *.cpp)

ADD_EXECUTABLE(testfoo ${SRCS})

target_link_libraries(testfoo PRIVATE GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)

# TARGET_LINK_LIBRARIES(testfoo
#     # libfoo
#     libgtest
#     libgmock
# )

add_test(NAME testfoo
         COMMAND testfoo)