find_package(GTest CONFIG REQUIRED)
# target_link_libraries(main PRIVATE GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)

# Create a libgtest target to be used as a dependency by test programs
# add_library(libgtest IMPORTED STATIC GLOBAL)
# add_dependencies(libgtest gtest)

# # Set libgtest properties
# set_target_properties(libgtest PROPERTIES
#     "IMPORTED_LOCATION" "${binary_dir}/googlemock/gtest/libgtest.a"
#     "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
# )

# # Create a libgmock target to be used as a dependency by test programs
# add_library(libgmock IMPORTED STATIC GLOBAL)
# add_dependencies(libgmock gtest)

# # Set libgmock properties
# set_target_properties(libgmock PROPERTIES
#     "IMPORTED_LOCATION" "${binary_dir}/googlemock/libgmock.a"
#     "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
# )

# I couldn't make it work with INTERFACE_INCLUDE_DIRECTORIES
# include_directories("${source_dir}/googletest/include"
#                     "${source_dir}/googlemock/include")

add_subdirectory(testfoo)