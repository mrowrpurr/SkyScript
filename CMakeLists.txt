cmake_minimum_required(VERSION 3.21)

project(
        SkyScript
        VERSION 0.0.1
        LANGUAGES CXX
)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(SKYSCRIPT_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

if (MSVC)
    add_compile_definitions(
            UNICODE
            _UNICODE
            NOMINMAX
            _CRT_SECURE_NO_WARNINGS # Stop telling me to use strcpy_s please
    )
endif()

add_subdirectory(runner)

enable_testing()
add_subdirectory(spec)
