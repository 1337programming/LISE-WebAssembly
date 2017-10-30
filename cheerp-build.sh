# Get the sources
echo Getting sources

mkdir cheerp
cd cheerp
export CHEERP_SRC=$PWD
git clone https://github.com/leaningtech/cheerp-llvm
cd  cheerp-llvm/tools/
git clone https://github.com/leaningtech/cheerp-clang clang
cd $CHEERP_SRC
git clone https://github.com/leaningtech/cheerp-utils
git clone https://github.com/leaningtech/cheerp-newlib
git clone https://github.com/leaningtech/cheerp-libcxx
git clone https://github.com/leaningtech/cheerp-libcxxabi
git clone https://github.com/leaningtech/cheerp-libs

# Build Cheerp LLVM/clang based compiler
echo building LLVM/clang compiler

cd $CHEERP_SRC/cheerp-llvm
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="ARM;CheerpBackend;CheerpWastBackend;X86" ..
make -j4
make install

# Build Cheerp Utilities
echo building utils

cd $CHEERP_SRC/cheerp-utils
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp ..
make install

# Build Cheerp C library (newlib)
echo building Cheerp C library

cd $CHEERP_SRC/cheerp-newlib/newlib
mkdir build
cd build
../configure --host=cheerp-genericjs --with-cxx-headers=$CHEERP_SRC/cheerp-libcxx/include --prefix=/opt/cheerp --enable-newlib-io-long-long --enable-newlib-iconv --enable-newlib-iconv-encodings=utf-16,utf-8,ucs_2
make
make install
CHEERP_PREFIX=/opt/cheerp ../build-bc-libs.sh genericjs

# Build Cheerp C++ library
echo building Cheerp C++ library

cd $CHEERP_SRC/cheerp-libcxx
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/opt/cheerp/share/cmake/Modules/CheerpToolchain.cmake -DLIBCXX_ENABLE_SHARED=OFF -DLIBCXX_ENABLE_ASSERTIONS=OFF -DLIBCXX_CXX_ABI_INCLUDE_PATHS=$CHEERP_SRC/cheerp-libcxxabi/include -DLIBCXX_CXX_ABI=libcxxabi ..
make
make install

# Build Cheerp C++ ABI library
echo building cheerp C++ ABI library

cd $CHEERP_SRC/cheerp-libcxxabi
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/opt/cheerp/share/cmake/Modules/CheerpToolchain.cmake -DLIBCXXABI_ENABLE_SHARED=OFF -DLIBCXXABI_ENABLE_ASSERTIONS=OFF -DLIBCXXABI_LIBCXX_PATH=$CHEERP_SRC/cheerp-libcxx/ -DLIBCXXABI_LIBCXX_INCLUDES=$CHEERP_SRC/cheerp-libcxx/include -DLIBCXXABI_ENABLE_THREADS=0 -DLLVM_CONFIG=/opt/cheerp/bin/llvm-config ..
make
make install

# Build Cheerp libraries
echo Building Cheerp libraries

cd $CHEERP_SRC/cheerp-libs

## Cheerp GLES implementation

make -C webgles install INSTALL_PREFIX=/opt/cheerp CHEERP_PREFIX=/opt/cheerp

## Cheerp optimized standard libraries

make -C stdlibs install_genericjs INSTALL_PREFIX=/opt/cheerp CHEERP_PREFIX=/opt/cheerp


# Build experimental asm.js version of standard libraries

echo Building asm.js versions

## Build Cheerp C library (newlib)

cd $CHEERP_SRC/cheerp-newlib/newlib
mkdir build_asmjs
cd build_asmjs
../configure --host=cheerp-asmjs --with-cxx-headers=$CHEERP_SRC/cheerp-libcxx/include --prefix=/opt/cheerp --enable-newlib-io-long-long --enable-newlib-iconv --enable-newlib-iconv-encodings=utf-16,utf-8,ucs_2
make
make install
CHEERP_PREFIX=/opt/cheerp ../build-bc-libs.sh asmjs

## Build Cheerp C++ library

cd $CHEERP_SRC/cheerp-libcxx
mkdir build_asmjs
cd build_asmjs
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/opt/cheerp/share/cmake/Modules/CheerpToolchain.cmake -DLIBCXX_ENABLE_SHARED=OFF -DLIBCXX_ENABLE_ASSERTIONS=OFF -DLIBCXX_CXX_ABI_INCLUDE_PATHS=$CHEERP_SRC/cheerp-libcxxabi/include -DLIBCXX_CXX_ABI=libcxxabi -DCHEERP_MODE=asmjs ..
make
make install

## Build Cheerp C++ ABI library

cd $CHEERP_SRC/cheerp-libcxxabi
mkdir build_asmjs
cd build_asmjs
cmake -DCMAKE_INSTALL_PREFIX=/opt/cheerp -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/opt/cheerp/share/cmake/Modules/CheerpToolchain.cmake -DLIBCXXABI_ENABLE_SHARED=OFF -DLIBCXXABI_ENABLE_ASSERTIONS=OFF -DLIBCXXABI_LIBCXX_PATH=$CHEERP_SRC/cheerp-libcxx/ -DLIBCXXABI_LIBCXX_INCLUDES=$CHEERP_SRC/cheerp-libcxx/include -DLIBCXXABI_ENABLE_THREADS=0 -DLLVM_CONFIG=/opt/cheerp/bin/llvm-config -DCHEERP_MODE=asmjs ..
make
make install

## Build Cheerp libraries

cd $CHEERP_SRC/cheerp-libs

### Cheerp optimized standard libraries

make -C stdlibs install_asmjs INSTALL_PREFIX=/opt/cheerp CHEERP_PREFIX=/opt/cheerp
