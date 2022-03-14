function(setupSpecs suiteName INCLUDES)
    set(executableName spec-${suiteName})

    # Get all of the test files (under the current cmake folder)
    file(GLOB_RECURSE SPEC_FILES *.cpp *.h)

    # Setup executable
    add_executable(${executableName} ../specHelper.h ../specHelper.cpp ${SPEC_FILES})

    # Bandit (testing framework)
    find_path(BANDIT_INCLUDE_DIRS "bandit/adapters.h")
    target_include_directories(${executableName} PRIVATE ${BANDIT_INCLUDE_DIRS})

    # Snowhouse (test assertions)
    find_path(SNOWHOUSE_INCLUDE_DIRS "snowhouse/assert.h")
    target_include_directories(${executableName} PRIVATE ${SNOWHOUSE_INCLUDE_DIRS})

    # spdlog for logging
    target_link_libraries(${executableName} PRIVATE spdlog::spdlog spdlog::spdlog_header_only)

    # If additional INCLUDES were provided, add them to a list of folders to add as include directories
    set(SPEC_INCLUDE_DIRS "")
    foreach(dir IN LISTS ARGN)
        if(${dir} STREQUAL yaml)
            include(yaml)
            setupYamlDependencies(${executableName} PRIVATE)
        else()
            list(APPEND SPEC_INCLUDE_DIRS ${SKYSCRIPT_ROOT_DIR}/${dir})
        endif()
    endforeach()
    if(SPEC_INCLUDE_DIRS)
        target_include_directories(${executableName} PRIVATE ${SPEC_INCLUDE_DIRS})
    endif()

endfunction()

