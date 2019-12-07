#!/bin/sh

set -o errexit

# -------------------------------------------- #
# Location
# -------------------------------------------- #
ROOT_DIR="$(pwd)"
CMAKE_DIR="$ROOT_DIR/cmake"
WRAPPER_DIR="$ROOT_DIR/wrapper"
APPLICATION_DIR="$ROOT_DIR/application"

# -------------------------------------------- #
# Make temp directory
# -------------------------------------------- #
XCODE_DIR="$WRAPPER_DIR/Xcode"
WEB_ASSEMBLY_DIR="$WRAPPER_DIR/WebAssembly"
TEMP_DIR_LIST=("$XCODE_DIR" "$WEB_ASSEMBLY_DIR")

for TEMP_DIR in ${TEMP_DIR_LIST[@]}
do
    echo "Check temp directory: $TEMP_DIR"
    if [ ! -d "$TEMP_DIR" ] 
    then
        mkdir "$TEMP_DIR"
    fi
done
# -------------------------------------------- #
# Generate iOS build system
# -------------------------------------------- #
cmake -DCMAKE_SYSTEM_NAME="iOS" \
      -G "Xcode" \
      -S "$CMAKE_DIR" \
      -B "$XCODE_DIR"

echo "
# -------------------------------------------- #
# Generate iOS build system with Xcode done
# -------------------------------------------- #
"

# -------------------------------------------- #
# Generate Android build system
# -------------------------------------------- #

ninja --version

echo "
# -------------------------------------------- #
# Android should genereate by AndroidStudio
# Do nothing here
# -------------------------------------------- #
"

# -------------------------------------------- #
# Genreate WebAssembly build system
# -------------------------------------------- #
# 1. Download SDK
EMSDK_GIT="$ROOT_DIR/emsdk"
if [ -d $EMSDK_GIT ] 
then
    $EMSDK_GIT/emsdk update-tags
else
    git clone https://github.com/emscripten-core/emsdk.git $EMSDK_GIT
    $EMSDK_GIT/emsdk install latest
fi
$EMSDK_GIT/emsdk activate latest

echo "
# -------------------------------------------- #
# Download Emscripten SDK done
# -------------------------------------------- #
"

# 2. Locate EMSDK offered tool chain file
CMAKE_TOOLCHAIN_FILE="$ROOT_DIR/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake"

# 3. CMake generate
cmake -DWEBASSEMBLY=YES \
      -DCMAKE_TOOLCHAIN_FILE="$CMAKE_TOOLCHAIN_FILE" \
      -S "$CMAKE_DIR" \
      -B "$WEB_ASSEMBLY_DIR"

echo "
# -------------------------------------------- #
# Generate WebAssembly build system with Emscripten toolchain
# -------------------------------------------- #
"

# -------------------------------------------- #
# End 
# -------------------------------------------- #
echo "
# -------------------------------------------- #
# -------------------------------------------- #
# -------------------------------------------- #

SET UP END:

*  Already set up iOS/Android/Electron/Web Project
*  All project can work with source C++ code 
*  Temp fold & files are emsdk/Xcode/WebAssembly 

iOS Platform:

1. Should use ./application/ios/Render.xcworkspace project
2. Wrapper is a framework target named AlgorithmSDK
3. AlgorithmSDK.xcodeproj was generated by cmake use -G \"Xcode\"

Android Platform:

1. Should use ./application/android as project root directory
2. Wrapper is a AndroidLibray with package name com.sdk.sdk
3. Wrapper is setup by manual at ./wrapper/JNI
4. AndroidStudio is no need cmake generate
4. Use CMakeLists.txt by configure \"externalNativeBuild\" at ./wrapper/JNI/sdk/build.gradle
5. Use source code by configure ./application/android/settings.gradle

Desktop Platform (Electron) & Web Platform:

1. Should use ./application/electron & ./application/web as project root
2. Electron & Web share the AlgorithmSDK.js & AlgorithmSDK.wasm
3. AlgorithmSDK need download emsdk as compiler
4. Wrapper is a cmake generate build system with special emsdk toolchain
5. AlgorithmSDK can build synchrony version, default is asynchrony
6. Electron import wasm both via node & browser
7. Web import wasm via browser and access via http server
8. Run electron use \"cd ./application/electron && sh build.sh\"
9. Run web use \"cd ./application/web && sh build.sh\"

# -------------------------------------------- #
# -------------------------------------------- #
# -------------------------------------------- #
" 





