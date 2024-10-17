# AREG SDK Demo Project

---

## Repository Status

This project demonstrates how to integrate and use the AREG SDK for various purposes. The current build status is shown below:

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)
[![MSBuild](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml)
[![CodeQL](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml)

---

## Introduction

The **AREG SDK Demo Project** provides a practical example and template for developers to create new projects using the [AREG SDK](https://github.com/aregtech/areg-sdk/) or integrating it into existing projects.

This demo showcases three primary ways for seamless integration of AREG SDK into your project:

1. **Fetching source code using cmake**: Directly fetch AREG SDK source files and build them alongside your project using CMake.
2. **Using prebuilt vcpkg packages**: Integrate the AREG SDK as a package via CMake and vcpkg.
3. **Adding AREG SDK as a submodule**: Add AREG SDK as a Git submodule to your project to integrate with `MSBuild` and/or `cmake`.

Each method is described in detail below.

---

## Integration Methods

### Method 1: Integrate by Fetching AREG SDK Source Code

To integrate the AREG SDK by fetching its source code, modify your project’s `CMakeLists.txt` to include the following script:

```cmake
include(FetchContent)
FetchContent_Declare(
  areg-sdk
  GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
  GIT_TAG "master"
)
FetchContent_MakeAvailable(areg-sdk)

# Set the root directory of the fetched AREG SDK
set(AREG_SDK_ROOT "${areg-sdk_SOURCE_DIR}")
include_directories(${AREG_SDK_ROOT}/framework)
```

Once fetched, you can use the AREG SDK libraries in your project via the `areg::` namespace:

- `areg::areg` for the core framework library
- `areg::aregextend` for extended objects
- `areg::areglogger` for the logging client API

Projects built by fetching the AREG SDK source code directly, compile it alongside project code.
Developers can also access the code generator (`codegen`), multicast router (`mcrouter`), and logging services (`logger`).

---

### Method 2: Integrate via AREG SDK Package (vcpkg)

> [!NOTE]: AREG SDK is prepared and tested to be a `vcpkg` package. It is expected to be included in the upcoming version 2.0.0

Projects using CMake can integrate AREG SDK through the `vcpkg` package manager. To install if follow these steps:

1. Clone, build and install vcpkg by following the instructions in the [official vcpkg repository](https://github.com/microsoft/vcpkg).
2. Install the AREG SDK package using the following commands:

**Windows (64-bit):**
```bash
vcpkg install areg:x64-windows
```

**Linux (64-bit):**
```bash
vcpkg install areg:x64-linux
```

After installing the package, add the vcpkg toolchain to your project displayed after running this command:
```bash
vcpkg integrate install
```

To include the AREG SDK package in your project, update your `CMakeLists.txt` like this:
```cmake
find_package(areg CONFIG REQUIRED)
include_directories(${AREG_FRAMEWORK})
```

This method provides a simpler and more modular approach to integrating the AREG SDK.

---

### Method 3: Integrate AREG SDK as a Git Submodule

Alternatively, you can add AREG SDK as a submodule to your project. This is particularly useful for managing dependencies in Microsoft Visual Studio solutions. To integrate AREG SDK as a submodule, add the following to your `.gitmodules` file:

```txt
[submodule "thirdparty/areg-sdk"]
  path = thirdparty/areg-sdk
  url = https://github.com/aregtech/areg-sdk.git
```

Then run the following commands to update and/or fetch the submodule:

```bash
git submodule update --init --recursive
git submodule update --remote --recursive
```

Add the AREG SDK to your `CMakeLists.txt` like this:
```cmake
set(AREG_SDK_ROOT "${CMAKE_SOURCE_DIR}/thirdparty/areg-sdk")
include("${AREG_SDK_ROOT}/CMakeLists.txt")
```

This method is particularly useful for Microsoft Visual Studio builds by including desired project of AREG SDK in your solution file.

---

## Advanced Features

The AREG SDK can be integrated before or after the first call of `project()` in CMake, depending on your needs.
This flexibility allows for custom configurations, such as specifying the compiler or enabling features like shared/static libraries, logging, and advanced objects.
To explore this flexibility, the demo project includes a compiler option `INTEGRATE_AREG_BEFORE_PROJECT`. Set this option to `TRUE` or `FALSE` to experiment with both approaches.

For more advanced configuration, include [areg.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/areg.cmake) in your `CMakeLists.txt` file
and refer to the available options described in the [user.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/user.cmake)
file located in the `conf/cmake` directory of the AREG SDK.

---

## Building the AREG SDK Demo Project

To build the demo applications, ensure that you have:

1. CMake (version 3.20 or higher)
2. Java (version 17 or higher)
3. C++ compiler (standard 17 or higher)

**Clone the demo project:**
```bash
git clone https://github.com/aregtech/areg-sdk-demo.git
```

**Build using CMake (fetching AREG SDK sources):**
```bash
cmake -B ./build
cmake --build ./build
```

**Build using AREG SDK as a package:**
```bash
cmake -B ./build -DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake
cmake --build ./build
```

**Build with Microsoft Visual Studio:**
Ensure that you cloned the repository with submodule by calling `git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git`.
Open the solution file (`areg-sdk-demo.sln`) and compile.

---

## Demo Applications

The demo applications are located in the `./demo/` directory. They are simple examples taken from the [AREG SDK examples](https://github.com/aregtech/areg-sdk/tree/master/examples). You can explore, modify, or contribute new examples to showcase additional features or use cases.

---

## Contribution Guidelines

Contributions are welcome! You can:

- Add new example projects
- Provide configuration and build examples
- Create workflows for automated builds and tests


To contribute:

1. Fork the repository.
2. Implement your changes.
3. Ensure compatibility with CMake, Microsoft Visual Studio, and multiple compilers (GCC, MSVC, Clang).
4. Submit a Pull Request with a detailed description.


---

## License

This project is licensed under the [MIT License](https://github.com/aregtech/areg-sdk-demo/blob/main/LICENSE), offering flexibility for personal and commercial use.

---

## Issues and Feedback

For any change requests or bug reports, please submit an issue in the [Issues](https://github.com/aregtech/areg-sdk-demo/issues) section. We value your feedback and contributions!
