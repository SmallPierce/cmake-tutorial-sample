# cmake-tutorial-sample

This is a tutorial of CMake for beginners. It starts from **"HelloWorld"** to **"CrossPlatform Compile"** step by step.

## Run Sample

Run sample 01-07 use command like 

```SH
cd cmake-tutorial-sample/01-helloworld
sh build.sh
```

The last sample 08-cross_platform should setup environment first.

## Setup 08-cross_platform Environment

Only verified on Mac, before run build.sh you should install

* Xcode/AndroidStudio
* CMake
* Ninjia
* NDK
* node
* electron
* git

then execute command 

```SH
cd cmake-tutorial-sample/08-cross_platform
sh build.sh
```

If it sets up success, you will see 

```SH

SET UP END:

*  Already set up iOS/Android/Electron/Web Project
*  All project can work with source C++ code 
*  Temp fold & files are emsdk/Xcode/WebAssembly 

```

## More Information

### iOS Platform:

1. Should use ./application/ios/Render.xcworkspace project
2. Wrapper is a framework target named AlgorithmSDK
3. AlgorithmSDK.xcodeproj was generated by cmake use -G \"Xcode\"

### Android Platform:

1. Should use ./application/android as project root directory
2. Wrapper is a AndroidLibray with package name com.sdk.sdk
3. Wrapper is setup by manual at ./wrapper/JNI
4. AndroidStudio is no need cmake generate
4. Use CMakeLists.txt by configure \"externalNativeBuild\" at ./wrapper/JNI/sdk/build.gradle
5. Use source code by configure ./application/android/settings.gradle

### Desktop Platform (Electron) & Web Platform:

1. Should use ./application/electron & ./application/web as project root
2. Electron & Web share the AlgorithmSDK.js & AlgorithmSDK.wasm
3. AlgorithmSDK need download emsdk as compiler
4. Wrapper is a cmake generate build system with special emsdk toolchain
5. AlgorithmSDK can build synchrony version, default is asynchrony
6. Electron import wasm both via node & browser
7. Web import wasm via browser and access via http server
8. Run electron use \"cd ./application/electron && sh build.sh\"
9. Run web use \"cd ./application/web && sh build.sh\"

## Documents

The documents have publiced on [my blog](http://alanli7991.github.io) and written by Chinese.