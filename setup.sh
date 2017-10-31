## Emscripten activate

#~/emsdk/emsdk install --build=Release sdk-incoming-64bit binaryen-master-64bit
#~/emsdk/emsdk activate --global --build=Release sdk-incoming-64bit binaryen-master-64bit
#source ~/emsdk/emsdk_env.sh


## Building binaries
mkdir build
cd build/
# Edit this with emsdk path
# cmake CMAKE_TOOLCHAIN_FILE=~/emsdk/emscripten/1.37.13/cmake/Modules/Platform/Emscripten.cmake .. (this doesn't work)
# cmake -DCMAKE_TOOLCHAIN_FILE=~/emsdk/emscripten/1.37.22/cmake/Modules/Platform/Emscripten.cmake -G "Unix Makefiles" ..
emconfigure .
emmake make
make

# ~/emsdk/emscripten/1.37.22/em++ --bind -o build.emscripten/client.js src/Application.cpp src/Application_Bindings.cpp src/MyClass.cpp
