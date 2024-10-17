# AREG SDK Demo Project

---

## Repository Status

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)
[![MSBuild](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml)
[![CodeQL](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml)

---

## Introduction

The **AREG SDK Demo Project** provides a practical example and template for creating new projects using the [AREG SDK](https://github.com/aregtech/areg-sdk/) or integrating it into existing projects.

This demo showcases three primary ways to integrate the AREG SDK into your project:

1. **Fetching source code**: Directly fetch AREG SDK source files and build them alongside your project using CMake.
2. **Using prebuilt packages**: Integrate the AREG SDK as a package via CMake and vcpkg.
3. **Using AREG SDK as a submodule**: Add AREG SDK as a Git submodule to your project.

Each method is described in detail below.

---

## Integration Methods

### 1. Fetching AREG SDK Sources

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

---

### 2. Using AREG SDK as a Package (via vcpkg)

> **Note**: AREG SDK is prepared to be a `vcpkg` package and will be officially added after the 2.0.0 release.

Projects that use CMake can integrate the AREG SDK through vcpkg once it’s available as a package. To install it:

1. Clone and build [vcpkg](https://github.com/microsoft/vcpkg).
2. Install the AREG SDK package using the following commands:

**Windows (64-bit):**
```bash
vcpkg install areg:x64-windows
```

**Linux (64-bit):**
```bash
vcpkg install areg:x64-linux
```

After installing the package, add the vcpkg toolchain to your project:
```bash
vcpkg integrate install
```
In your `CMakeLists.txt`, use:
```cmake
find_package(areg CONFIG REQUIRED)
include_directories(${AREG_FRAMEWORK})
```

---

### 3. Adding AREG SDK as a Submodule

To integrate the AREG SDK as a Git submodule, add the following to your `.gitmodules` file:

```txt
[submodule "thirdparty/areg-sdk"]
  path = thirdparty/areg-sdk
  url = https://github.com/aregtech/areg-sdk.git
```

Update the submodule with:
```bash
git submodule update --init --recursive
```

Then, include AREG SDK in your `CMakeLists.txt`:
```cmake
set(AREG_SDK_ROOT "${CMAKE_SOURCE_DIR}/thirdparty/areg-sdk")
include("${AREG_SDK_ROOT}/CMakeLists.txt")
```

This method is particularly useful for Microsoft Visual Studio builds.

---

## Advanced Features

The AREG SDK can be integrated before or after the first call of `project()` in CMake, depending on your needs. To explore this flexibility, the demo project includes a compiler option: `INTEGRATE_AREG_BEFORE_PROJECT`. Set this option to `TRUE` or `FALSE` to experiment with both approaches.

For more advanced configuration, refer to the `areg.cmake` file located in the `conf/cmake` directory of the AREG SDK. This file allows customization of compiler options, logging, shared/static library settings, and more.

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

For Microsoft Visual Studio, clone the repository with submodules and open the solution file (`areg-sdk-demo.sln`).

---

## Demo Applications

The demo applications are located in the `./demo/` directory. They are simple examples taken from the [AREG SDK examples](https://github.com/aregtech/areg-sdk/tree/master/examples). You can explore, modify, or contribute new examples to showcase additional features or use cases.

---

## Contributing

Contributions are welcome! You can:

- Add new example projects
- Provide configuration and build examples
- Create workflows for automated builds and tests
- Add unit tests

Fork the repository, make your changes, and submit a pull request.

---

## License

This project is licensed under the [MIT License](https://github.com/aregtech/areg-sdk-demo/blob/main/LICENSE).

---

## Issues and Feedback

For any change requests or bug reports, please submit an issue in the [Issues](https://github.com/aregtech/areg-sdk-demo/issues) section. We value your feedback and contributions!
