# Areg SDK Demo Project

## Repository Status

This project demonstrates how to integrate and use the Areg SDK for various purposes. The current build status is shown below:

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)
[![MSBuild](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml)
[![CodeQL](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml)

---

# Table of Contents

- [Introduction](#introduction)
- [System Requirements](#system-requirements)
  - [General Requirements](#general-requirements)
  - [Platform-Specific Requirements](#platform-specific-requirements)
- [Integration Methods](#integration-methods)
  - [Method 1: Integrate by Fetching Areg SDK Source Code](#method-1-integrate-by-fetching-areg-sdk-source-code)
  - [Method 2: Integrate via Areg SDK Package (vcpkg)](#method-2-integrate-via-areg-sdk-package-vcpkg)
  - [Method 3: Integrate Areg SDK as a Git Submodule](#method-3-integrate-areg-sdk-as-a-git-submodule)
- [Advanced Features](#advanced-features)
- [Building the Areg SDK Demo Project](#building-the-areg-sdk-demo-project)
- [Demo Applications](#demo-applications)
- [Contribution Guidelines](#contribution-guidelines)
- [License](#license)
- [Issues and Feedback](#issues-and-feedback)

---

## Introduction

The **Areg SDK Demo Project** provides a practical example and template for developers to create new projects using the [Areg SDK](https://github.com/aregtech/areg-sdk/) or integrating it into existing projects.

This demo showcases three primary ways to integrate Areg SDK into your project:

1. **Fetching source code using CMake** — directly fetch Areg SDK source files and build them alongside your project.  
2. **Using pre-built vcpkg packages** — integrate the Areg SDK as a package via CMake and vcpkg.  
3. **Adding Areg SDK as a Git submodule** — integrate Areg SDK into your project to work with MSBuild and/or CMake.

Each method is described in detail below.

---

## System Requirements

### General Requirements
Ensure your system includes the following:

- **Git** for repository cloning.  
- **Java 17+** for code generation tools.  
- **Compilers**: GNU or LLVM (Linux); MSVC or Clang (Windows). Must support **C++17** or newer.  
- **Build Tools**: CMake 3.20+ or Microsoft Visual Studio 2019+.  

### Platform-Specific Requirements

- **Linux**: Install **ncurses** if you want to compile with extended objects.  
- **Windows**: Requires Microsoft Visual C++, including **CMake**, **Clang for Windows**, and **MFC** for GUI examples.  
- **Optional Libraries**:  
  - **Google Test (GTest)** for unit tests (or let Areg SDK build it from sources).  
  - **SQLite3** (or let Areg SDK build from sources).  

---

## Integration Methods

### Method 1: Integrate by Fetching Areg SDK Source Code

Modify your project’s `CMakeLists.txt` to include:

```cmake
include(FetchContent)
FetchContent_Declare(
  areg-sdk
  GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
  GIT_TAG "master"
)
FetchContent_MakeAvailable(areg-sdk)

# Set the root directory of the fetched Areg SDK
set(AREG_SDK_ROOT "${areg-sdk_SOURCE_DIR}")
include_directories(${AREG_SDK_ROOT}/framework)
````

Once fetched, you can use the Areg SDK libraries via the `areg::` namespace:

* `areg::areg` — core framework library
* `areg::aregextend` — extended objects
* `areg::areglogger` — logging client API

This method also gives access to the **code generator (`codegen`)**, **multicast router (`mcrouter`)**, and **logging services (`logger`)**.

---

### Method 2: Integrate via Areg SDK Package (vcpkg)

> [!IMPORTANT]
> Areg SDK is prepared and tested as a `vcpkg` package. It is expected to be included in the upcoming version 2.0.0.

Steps:

1. Clone, build, and install vcpkg (see [vcpkg repo](https://github.com/microsoft/vcpkg)).
2. Install the Areg SDK package:

**Windows (64-bit):**

```bash
vcpkg install areg:x64-windows
```

**Linux (64-bit):**

```bash
vcpkg install areg:x64-linux
```

3. Integrate vcpkg into your project:

```bash
vcpkg integrate install
```

4. Update `CMakeLists.txt`:

```cmake
find_package(areg CONFIG REQUIRED)
include_directories(${AREG_FRAMEWORK})
```

Compile with:

```bash
cmake -B ./build -DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake
```

This method offers a modular approach to using the Areg SDK.

---

### Method 3: Integrate Areg SDK as a Git Submodule

Add Areg SDK as a submodule (useful for Visual Studio):

```txt
[submodule "thirdparty/areg-sdk"]
  path = thirdparty/areg-sdk
  url = https://github.com/aregtech/areg-sdk.git
```

Initialize:

```bash
git submodule update --init --recursive
git submodule update --remote --recursive
```

Update `CMakeLists.txt`:

```cmake
set(AREG_SDK_ROOT "${CMAKE_SOURCE_DIR}/thirdparty/areg-sdk")
include("${AREG_SDK_ROOT}/CMakeLists.txt")
```

This allows direct inclusion of Areg SDK projects in Visual Studio solutions.

---

## Advanced Features

The Areg SDK can be integrated **before or after** the first `project()` call in CMake, enabling flexible customization (e.g., compiler choice, shared/static libraries, logging, advanced objects).

This demo includes an option `INTEGRATE_AREG_BEFORE_PROJECT`. Set it to `TRUE` or `FALSE` to experiment with both approaches.

For more customization, include [areg.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/areg.cmake) and check [user.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/user.cmake).

You can include via:

```cmake
include("${AREG_CMAKE_CONFIG_DIR}/areg.cmake")
```

or (for vcpkg integration):

```cmake
include("${AREG_CMAKE_EXPORTS}")
```

---

## Building the Areg SDK Demo Project

Ensure:

1. CMake 3.20+
2. Java 17+
3. C++17+ compiler

**Clone the repo:**

```bash
git clone https://github.com/aregtech/areg-sdk-demo.git
```

**Build (fetching Areg SDK sources):**

```bash
cmake -B ./build
cmake --build ./build
```

**Build (Areg SDK via vcpkg):**

```bash
cmake -B ./build -DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake
cmake --build ./build
```

**Build with Visual Studio:**

Open `areg-sdk-demo.sln` and compile.

> [!IMPORTANT]
> For Visual Studio builds, clone with submodules:
>
> ```bash
> git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
> ```

---

## Demo Applications

Located in `./demo/`.
They are adapted from [Areg SDK examples](https://github.com/aregtech/areg-sdk/tree/master/examples).
You can explore, modify, or add new demos.

---

## Contribution Guidelines

Contributions are welcome! You can:

* Add new example projects
* Provide configuration/build examples
* Create CI/CD workflows

To contribute:

1. Fork the repo.
2. Make your changes.
3. Ensure compatibility (CMake, Visual Studio, GCC, MSVC, Clang).
4. Open a Pull Request with details.

---

## License

Licensed under the [MIT License](https://github.com/aregtech/areg-sdk-demo/blob/main/LICENSE).
Free for personal and commercial use.

---

## Issues and Feedback

For bugs or feature requests, open an issue in the [Issues](https://github.com/aregtech/areg-sdk-demo/issues) section.
Your feedback is appreciated!
