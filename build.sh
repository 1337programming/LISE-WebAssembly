## Emscripten activate

#~/emsdk/emsdk install --build=Release sdk-incoming-64bit binaryen-master-64bit
#~/emsdk/emsdk activate --global --build=Release sdk-incoming-64bit binaryen-master-64bit
#source ~/emsdk/emsdk_env.sh

echo Make sure to activate your emscripten environment
rm -rf build
mkdir build
cd build/
emconfigure cmake ../
emmake make
#cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/Emscripten.cmake -G "Unix Makefiles" .. #Replace this with your emscripten cmake
#make

## Building binaries
#mkdir build
#cd build/
## Edit this with emsdk path
## cmake CMAKE_TOOLCHAIN_FILE=~/emsdk/emscripten/1.37.13/cmake/Modules/Platform/Emscripten.cmake .. (this doesn't work for some reason)
## cmake -DCMAKE_TOOLCHAIN_FILE=~/emsdk/emscripten/1.37.22/cmake/Modules/Platform/Emscripten.cmake -G "Unix Makefiles" ..
#emconfigure .
#emmake make
#make

# ~/emsdk/emscripten/1.37.22/em++ --bind -o build.emscripten/client.js src/Application.cpp src/Application_Bindings.cpp src/MyClass.cpp

# @TODO Build setup for libraries
# inside lib/assimp (ensure you have emscripten activated)
# emconfigure cmake .
# emmake make
# emcc -O2 code/CMakeFiles/assimp.dir/*.cpp.o -o lib-js/libassimp.so
