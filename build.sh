echo Make sure to activate your emscripten environment
rm -rf build
mkdir build
cd build/
emconfigure cmake ../
emmake make
