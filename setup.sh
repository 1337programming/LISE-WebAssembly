#!/usr/bin/env bash
# Setup Bash Script
# this script will setup llvm binaries for you for your project
# @TODO try to migrate this all into CMake

# Globals
RED_BRIGHT='\033[1;31m'
RED='\033[0;31m'
GREEN='\033[0;32m'
GREEN_BRIGHT='\033[1;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if emscripten is activated
if ! [ -x "$(command -v em++)" ]; then
  echo "Emscripten not installed, cannot find (em++, emconfigure, emmake). Is Emscripten not installed or not activate in your environment?"
  echo -e "${RED_BRIGHT}Emscripten is not activated!${RED}\nIf  http://webassembly.org/getting-started/developers-guide/ for instructions.${NC}" >&2
  exit 1
fi

echo -e "${GREEN_BRIGHT}Emscripten is active, proceeding...${NC}"

cd lib/

# Build function
function build() {
    rm CMakeCache.txt
    rm -rf lib-js
    mkdir lib-js
    emconfigure cmake .
    emmake make
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo FAIL
    fi
}

## Build Assimp
echo -e "${GREEN}Building Assimp LLVM Binaries...${NC}"
cd assimp/
build
em++ -O2 code/CMakeFiles/assimp.dir/*.cpp.o -o lib-js/libassimp.so
cd ../

## Build Bullet 3
echo -e "${YELLOW}Skipping Bullet 3${NC}, using Emscripten's internal Bullet port"

## Build Glad
echo -e "${GREEN}Building Glad LLVM Binaries...${NC}"
cd glad/
build
em++ -O2 CMakeFiles/glad.dir/src/*.o -o lib-js/libglad.so
cd ../

## Build GLFW
echo -e "${YELLOW}Skipping GLFW LLVM build${NC}, using Emscripten's internal GLFW port"

## Build GLM
echo -e "${GREEN}Building Glad LLVM Binaries...${NC}"
cd glm/
build
em++ -O2 glm/CMakeFiles/glm_dummy.dir/detail/*.o -o lib-js/libglm.so
cd ../

## Build stb
echo -e "${YELLOW}Skipping STB LLVM build,${NC} using Emscripten's internal STB_Image port"

echo -e "${GREEN_BRIGHT}LLVM Build Complete"