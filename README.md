# AREG SDK Demo Project

---

## Repository Status

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)
[![MSBuild](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml/badge.svg?branch=master)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml)
[![CodeQL](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/codeql.yml)

---

## Introduction

This repository serves as a practical example and template to create new projects based on [AREG SDK](https://github.com/aregtech/areg-sdk/) or integrating [AREG SDK](https://github.com/aregtech/areg-sdk/) into an existing project.

Currently, these are supported ways to integrate AREG SDK in the projects:
1. Integrate AREG SDK source codes in a projects by _fetching_ sources from official repository and compiling together with project codes using `cmake` tool.
2. Integrate AREG SDK binaries and header files as _areg package_ in a project to compile and link with AREG SDK libraries using `cmake` and `vcpkg` tools.
3. Integrate AREG SDK source codes in the project as a _submodule_ to be able to compile with `MSBuilds` and/or `cmake`.

Bellow there is the description of integration of each case.

---

## Integrate by fetching sources

Any project built with `cmake` tool can fetch the `areg-sdk` sources in the project, compile codes, link with `areg-sdk` libraries, and use available tools such as code generator (`codegen`) located in the `tools` subdirectory of `areg-sdk`, multi-cast router (`mcrouter`) and logging service (`logger`). To fetch AREG SDK sources and integrate in the project, the developers need to integrate the following script in the `CMakeLists.txt` file of the target project:
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
When sources are fetched, the header files are can be included in the source files and the libraries of `areg-skd` are accessed via `areg::` namespace, e.g. `areg::areg` to access `areg` framework library,
`areg::aregextend` to access AREG extended objects and `areg::areglogger` to access the logging client API library.

---

## Integrate by accessing package

> [!NOTE]
> At this moment the `vcpkg` does not contain `areg` package yet, but it is prepared and tested.
> It is planned to integrate `areg` package in the `vcpkg` after official release version 2.0.0.
> For this reason, at the moment it is very recommended to prepare the use of packaging and the fetching.

Any project built with `cmake` can use `areg` package available and installed in the system via `vcpkg` packaging tool, include header files of `areg-sdk`, and use available tools such as code generator (`codegen`) located in the `tools` subdirectory of `areg-sdk`, multi-cast router (`mcrouter`) and logging service (`logger`). To use `areg` package, clone [_vcpkg_](https://github.com/microsoft/vcpkg) project in your machine, build following the instructions available at [_vcpkg_ repository](https://github.com/microsoft/vcpkg).

Once you have installed `vcpkg` tool, you can make the package of `areg-sdk` available and use it in you project as any other library. To install `areg` framework, switch to `vcpkg` root directory and run following script in the command line:

**For 64-bit Windows system:**
```bash
vckpkg install areg:x64-windows
```

**For 64-bit Linux system:**
```bash
vckpkg install areg:x64-linux
```

This call will install `areg-sdk` libraries as `areg` package and all other optional dependencies like `sqlite3` and `ncurses`.
After installation, call this command, which will display the instruction of `cmake` option to compile project with libraries 
available in `vcpkg`.
```bash
vcpkg integrate install
```

Now the projects can use `areg` library. The projects should be configured with the option `-DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake`,
where `<vcpkg-root>` should be the real path to the `vcpkg` directory.
Or set the variable `CMAKE_TOOLCHAIN_FILE` to `<vcpkg-root>/scripts/buildsystems/vcpkg.cmake` before first call of `project()`
in your `CMakeLists.txt`

Bellow is the `cmake` script to integrate `areg-sdk` libraries of the `areg` package in the project:

```cmake
find_package(areg CONFIG REQUIRE)
include_directories(${AREG_FRAMEWORK})
```

The availability of the `areg` package can be checked via variable `areg_FOUND`, which is created after calling `find_package()`.
If the package availability is not required, the `find_package()` macro can be called like `find_package(areg CONFIG)`.

When package is found, the header files are can be included in the source files and the libraries of `areg-skd` are accessed via `areg::` namespace, e.g. `areg::areg` to access `areg` framework library,
`areg::aregextend` to access AREG extended objects and `areg::areglogger` to access the logging client API library.

Here is the example of code to use `areg` library in the project.
1. Create a `example.cpp` file with following content:
```cpp
// example.cpp
#include <iostream>
#include "areg/base/String.hpp"

int main()
{
	String hello("Hello from AREG SDK ...");
	std::cout << hello.getData() << std::endl;

	hello = "\'areg.init\' location -> ";
	hello += AREG_SHARE_INIT; // <== 'areg.init' file location
	std::cout << hello.getData() << std::endl;

	return 0;
}
```
2. Create `CMakeLists.txt` file with following content:
```cmake
# CMakeList.txt : include source and link with 'areg::areg'
cmake_minimum_required(VERSION 3.20.0)

project ("example" CXX)

find_package(areg CONFIG REQUIRED)
# Add source to this project's executable.
add_executable (example example.cpp)
target_link_libraries(example PRIVATE areg::areg)
```
3. Open command line in the root of this project and call this commend to configure and build project (replace `<vcpkg-root>` with the path of `vcpkg`):
```bash
cmake -B ./build -DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake
cmake --build ./build
```

For the better handling, the developer should consider both cases: when the `areg` package is available in the system and when it is not available.
In this case, the `cmake` script should look like this:
```cmake
find_package(areg CONFIG)
if (NOT areg_FOUND)
    # AREG package does not exist, fetch sources from GitHub.

    # Disable building AREG SDK examples and unit tests, we don't need them.
    option(AREG_BUILD_EXAMPLES  "No areg-sdk examples"   OFF)
    option(AREG_BUILD_TESTS     "No areg-sdk unit tests" OFF)

	# Fetch areg-sdk sources from GitHub
	include(FetchContent)
	FetchContent_Declare(
		areg-sdk
		GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
		GIT_TAG "master"
	)
	FetchContent_MakeAvailable(areg-sdk)
	# Set the root directory of the fetched AREG SDK
	set(AREG_SDK_ROOT "${areg-sdk_SOURCE_DIR}")
	set(AREG_FRAMEWORK "${AREG_SDK_ROOT}/framework")
endif()

# Include <areg-sdk-root>/framework to access header files.
include_directories(${AREG_FRAMEWORK})
```

In this example, the `cmake` tries to find `areg` package to use in the project. If it is not available, fetches the sources from GitHub repository
and then compile.

---

## Integrate as a submodule

Beside of above describe methods, `areg-sdk` can be as well integrated as a submodule in the project. In this case, the developers
should manually include the `CMakeLists.txt` file located in the `<areg-sdk root>` directory to include `areg-sdk` in the build.
Additionally, developer can include `areg-sdk` projects in the own Microsoft Visual Studio solution to build and use specific libraries.

To integrate `areg-sdk` as a submodule, the developers need to create `.gitmodules` file in the root of the project and specify
where the submodule should be fetched. For example, here the sources are fetched in the subdirectory `thirdparty/areg-sdk`:
```txt
[submodule "thirdparty/areg-sdk"]
	path = thirdparty/areg-sdk
	url = https://github.com/aregtech/areg-sdk.git
```

When file is created, open command line and call this `git` command:
```bash
git submodule update --init --recursive
git submodule update --remote --recursive
```

Do not forget to commit and push `.gitmodules` file and the submodule file `areg-sdk` to the repository. After this, source codes
of the project should be cloned with the flag `--recurse-submodule`. For example, this command clones the sources of `areg-sdk-demo`
project and copies submodule files in the subdirectory `thirdparty/areg-sdk` as it was described in the `.gitmodules` file.
```bash
git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
```

The integration as a submodule is useful if build project using _Microsoft Visual Studio_. In the build with `cmake`, submodules
are optional, but can be as well used. In this case, instead fetching sources, the developer should call `include` command of CMake:
```cmake
set(AREG_SDK_ROOT "${CMAKE_SOURCE_DIR}/thirdparty/areg-sdk")
include("${AREG_SDK_ROOT}/CMakeLists.txt")
```

---

## Advanced features

AREG Framework can be integrated in the project either before first call of `project()` or after. To demonstrate both possibilities,
`areg-sdk-demo` project has a compiler option `INTEGRATE_AREG_BEFORE_PROJECT`. Set the option `TRUE` to fetch and include
the sources of `areg-sdk` before first call of `project()`. In this case, for example, the developer can set preferred compiler
in the options of `areg-sdk`. For example, the call `cmake -B ./build -DAREG_COMPILER=g++` tells that the chosen compiler
is `g++`. Otherwise, if `areg-sdk` is included after the first call of `project()` the CMake may already setup the system
default compiler, unless developer does not specify it via option `CMAKE_COMPILER` parameter, or via `CXX` and `CC` environment
variables.

Additionally, to use the advanced features of AREG-SDK, developer should include `areg.cmake` file located in the
`conf/cmake` sub-directory in `<areg-sdk root>`. The advanced features can specify, for example, the type of the 
`areg` library (shared or static), the location of build binaries, use of advanced object, compilation with logs and other options.
The list of options to change are described in the [user.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/user.cmake) file 
of AREG SDK. Some options, like compiler preference, should be set before first call of `project()` in the `CMakeLists.txt`,
the other options can be set after. The `areg-sdk-demo` demonstrates these possibilities. Compile project with `cmake` 
option `-DINTEGRATE_AREG_BEFORE_PROJECT=TRUE` to fetch and/or integrate `areg-sdk` before first call of `project()`.

For details, see the content of [CMakeLists.txt](./CMakeLists.txt) file and compile the project with both options:

1. Fetch the sources or use `areg` package before first call of `project()`
```cmake
cmake build ./build -DINTEGRATE_AREG_BEFORE_PROJECT:BOOL=TRUE
```

2. Fetch the sources or use `areg` package after first call of `project()`
```cmake
cmake build ./build -DINTEGRATE_AREG_BEFORE_PROJECT:BOOL=FALSE
```

---

## Build of AREG SDK Demo project

This demonstration project utilizes the [areg-sdk](https://github.com/aregtech/areg-sdk/). The build process for this demonstration employs [`CMakeLists.txt`](https://github.com/aregtech/areg-sdk-demo/blob/main/CMakeLists.txt) and the `cmake` build tool. Before using demonstrated projects, make sure that you have installed
in your machine:
1. CMake build tool of version at least _3.20_.
2. Java of version at least _17_.

The Demo project will not compile the [examples](https://github.com/aregtech/areg-sdk/tree/master/examples) and unit test files of `areg-sdk`.
To compile examples, clone and compile `areg-sdk` project.

### Clone sources

Only the build with Microsoft Visual Studio requires cloning the `demo` project with submodules. In all other cases, it is enough only to clone this Demo project.

**Clone Demo sources without submodules:**
```bash
git clone https://github.com/aregtech/areg-sdk-demo.git
```

**Clone Demo sources with submodules:**
```bash
git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
```

### Quick Build

**Building with CMake and fetching the `areg-sdk` sources:**

To build Demo applications with CMake, the simplest way is to use this script in command line and pass no parameters. The configuration will use the default parameters and 
fetch the sources of `areg-sdk` to include in the build:
```bash
cmake -B ./build
cmake --build ./build
```

**Build with CMake and using `areg` package:**

To build Demo applications and trying to use `areg` package, use this script in command line and pass only `CMAKE_TOOLCHAIN_FILE` option by specifying the location of
`vcpkg.cmake`. Replace `<vcpkg-root>` with the path to the vcpkg root directory. If `areg` package was not found, it will automatically fetch `areg-sdk` sources:
```bash
cmake -B ./build -DCMAKE_TOOLCHAIN_FILE=<vcpkg-root>/scripts/buildsystems/vcpkg.cmake
cmake --build ./build -j 20
```

**Building with Microsoft Visual Studio:**

You should clone the `areg-sdk-demo` project with submodules to be able to compile the demo application in Microsoft Visual Studio:
```bash
git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
```
Then open the `areg-sdk-demo.sln` file in the Microsoft Visual Studio and build the applications.


### Other compiler options

The Demo project uses all options, which are valid for `areg-sdk`. The list of options that can be changed are listed in the header of
[user.cmake](https://github.com/aregtech/areg-sdk/blob/master/conf/cmake/user.cmake) file. Additionally, the Demo project has an option `INTEGRATE_AREG_BEFORE_PROJECT`,
which is used to demonstrate the possibility of integrating `areg` framework in the build process before and after the first call of `project()`.

---

## Demo applications

The demo applications are located in the [`./demo/`](https://github.com/aregtech/areg-sdk-demo/tree/main/demo) subdirectory of this repository. In order to keep things simple, we have included a few projects that were taken from the [examples](https://github.com/aregtech/areg-sdk/tree/master/examples) of the AREG SDK. Feel free to explore the existing demo examples and modify them as needed. You can also contribute new examples to showcase different functionalities or use cases of the AREG SDK.

---

## Contribution

You are welcome to contribute to this AREG SDK Demo repository by adding your own codes and scripts to demonstrate:

- New example projects.
- Configuration and build examples using various scripts and tools.
- Setting up new workflow actions for automatic builds and tests.
- Adding your own unit tests.

To contribute, please follow these steps:

1. Fork this AREG SDK Demo project.
2. Make the desired changes in your forked repository.
3. Ensure that everything compiles and runs correctly.
	- the applications must compile with CMake and with fetching the `areg-sdk` sources;
	- the applications must compile with CMake and `areg` package;
	- the applications must compile with compiler options `-DINTEGRATE_AREG_BEFORE_PROJECT=TRUE` and `-DINTEGRATE_AREG_BEFORE_PROJECT=FALSE`;
	- the applications must compile with Microsoft Visual Studio;
	- the applications must compile:
	   * under Linux platform: g++-gcc, c++-cc, clang++-clang compilers
	   * under Windows platform: MSVC, clang-cl compilers
	   * under Cygwin platform: g++-gcc, c++-cc
4. Create a Pull Request and provide a clear description of the changes. Please add appropriate labels to the Pull Request and commit your changes.

Once the Pull Request is reviewed and approved, it will be merged into the main repository.

We appreciate your contributions and look forward to seeing your additions to the AREG SDK Demo repository.

---

## Change Requests and Bug Reports

If you have any change requests or want to report bugs, please use the [Issues](https://github.com/aregtech/areg-sdk-demo/issues) tab in this repository. We will review your requests as soon as possible.

When creating an issue, please use appropriate labels to indicate whether it is a new feature request or a bug report. This helps us categorize and prioritize the issues effectively.

We appreciate your feedback and contributions to improve the AREG SDK Demo.

---

## License

The files and sources in this repository are provided under the [MIT License](https://github.com/aregtech/areg-sdk-demo/blob/main/LICENSE). They are offered without any warranty or restriction, allowing you the freedom to use them in any kind of project.

---
