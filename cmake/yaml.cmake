# yaml-cpp
function(setupYamlDependencies target type)
    find_package(yaml-cpp CONFIG REQUIRED)
    target_link_libraries(${target} ${type} yaml-cpp)
endfunction()
