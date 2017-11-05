# LISE WebAssembly (Work In Progress)

The purpose of this project is to create a very basic minimal CMake project able to compile C++ program using emscripten with the following features enabled:
* Linking to external C++ library crosscompiled to JS file
* Using bindings created via Embind
* Preloading assets files
* Sample OpenGL stack to get going

## How to use
1. Create build directory ```build``` and go there
2. Run cmake specifying toolchain file ```CMAKE_TOOLCHAIN_FILE=path/to/emscripten/emscripten/version/cmake/Modules/Platform/Emscripten.cmake```
3. Run ```make```

**Note:** You must build your LLVM libraries, see `build.sh` for guidance.

Compiled file called ```client.js``` along with the preloaded assets in file ```client.data``` will be put into ```build.emscripten``` directory. Check if it works by opening ```build.emscripten/index.html``` in browser.

## Tech Stack


Functionality           | Library
----------------------- | ------------------------------------------
Mesh Loading            | [assimp](https://github.com/assimp/assimp)
Physics                 | [bullet](https://github.com/bulletphysics/bullet3)
OpenGL Function Loader  | [glad](https://github.com/Dav1dde/glad)
Windowing and Input     | [glfw](https://github.com/glfw/glfw)
OpenGL Mathematics      | [glm](https://github.com/g-truc/glm)
Texture Loading         | [stb](https://github.com/nothings/stb)

## TODO

- [x] CMake Conversion 
- [x] Embind
- [x] Passing Emscripten Arguments 
- [x] Support uploading files
- [x] WASM Output (requires loader file)
- [x] Sample Vendor Compiling
- [x] Sample Vendor Runtime (must build LLVM separately) 
- [x] Select OpenGL libraries
- [ ] Script to build LLVM libraries
- [ ] JavaScript Loader
- [ ] Select Architecture
- [ ] Document Architecture
