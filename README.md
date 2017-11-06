# LISE WebAssembly (Work In Progress)

The purpose of this project is to create a very basic minimal CMake project able to compile C++ program using emscripten with the following features enabled:
* Linking to external C++ library crosscompiled to JS file
* Using bindings created via Embind
* Preloading assets files
* Sample OpenGL stack to get going

## Requirements

See the WebAssembly [setup](http://webassembly.org/getting-started/developers-guide/) to get all the requirements.

What you will need

* Python 2.7
* C++ Compiler
* CMake
* Emscripten

## How to use
1. Setup project `./setup.sh` - this will build and compile the libraries 
2. Build project `./build.sh` - this will build the project
3. See output in `dist/index.html`

**Note: there is no wasm loader at this time, see example output or modify output from `client.js` to `client.html`**


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
- [ ] Support uploading files
- [x] Provide example WASM output
- [x] WASM Output (requires loader file)
- [x] Sample Vendor Compiling
- [x] Sample Vendor Runtime 
- [x] Select OpenGL libraries
- [x] Script to build LLVM libraries
- [ ] Sample JavaScript Application
- [ ] Convert bash scripts in CMake (I suck at CMake)
- [ ] JavaScript Loader
- [ ] Select Architecture
- [ ] Document Architecture
- [ ] C++ Unit Testing Setup with Google Test
- [ ] Platform to support Web & Native
