cmake_minimum_required(VERSION 2.8)
cmake_policy(SET CMP0015 NEW)

project(emtest)

set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/dist)

# All C files for including into the project
include_directories("lib/assimp/include")
include_directories("lib/bullet/src")
include_directories("lib/emscripten/system/include")
include_directories("lib/glad/include")
include_directories("lib/glfw/include")
include_directories("lib/glm/glm")
include_directories("lib/stb")

# LLVM binaries
link_directories("lib/assimp/lib-js")
link_directories("lib/glad/lib-js")
link_directories("lib/glm/lib-js")

# Linking C & LLVM code
link_libraries("assimp")
# link_libraries("bullet")
# link_libraries("emscripten")
link_libraries("glad")
# link_libraries("glfw")
link_libraries("glm")
#link_libraries("stb")

file(GLOB_RECURSE CORE_HDR src/*.h)
file(GLOB_RECURSE CORE_SRC src/*.cpp)

#
# Trying usual cmake project compiler execution
#

add_definitions("-std=c++11")
add_executable(client ${CORE_SRC} ${CORE_HDR})

# set_target_properties(client PROPERTIES LINK_FLAGS "-s DEMANGLE_SUPPORT=1 --preload-file ${CMAKE_SOURCE_DIR}/assets --bind")
# @TODO preload-file breaks embind
set_target_properties(client PROPERTIES LINK_FLAGS "-O2 -s DEMANGLE_SUPPORT=1 -s USE_GLFW=3 -s USE_BULLET=1 -s STB_IMAGE=1 -s WASM=1 --bind")

