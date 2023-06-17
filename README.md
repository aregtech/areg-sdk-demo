# AREG SDK Demo Project

---

## Repository Status

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)
[![MSBuild](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml/badge.svg?branch=main)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/msbuild.yml)

---

## Introduction

This repository serves as a practical example and template for creating new projects or integrating the source code from the [AREG SDK](https://github.com/aregtech/areg-sdk/) into existing projects.

In this demonstration, the repository utilizes the [areg-sdk](https://github.com/aregtech/areg-sdk/) as a submodule, linked within the [`./thirdparty/`](https://github.com/aregtech/areg-sdk-demo/tree/main/thirdparty) subdirectory. The example project's source code can be found in the [`./demo/`](https://github.com/aregtech/areg-sdk-demo/tree/main/demo) subdirectory. The build process for this demonstration employs [`CMakeLists.txt`](https://github.com/aregtech/areg-sdk-demo/blob/main/CMakeLists.txt) and the `cmake` build tool.

To simplify testing, the build of [examples](https://github.com/aregtech/areg-sdk/tree/master/examples) of the [AREG SDK](https://github.com/aregtech/areg-sdk/) has been disabled by setting `AREG_BUILD_EXAMPLES` to **OFF**. To enable the build of the AREG SDK example, you can make the necessary changes in the [`CMakeLists.txt`](https://github.com/aregtech/areg-sdk-demo/blob/main/CMakeLists.txt) file or pass the corresponding option via the command line, as shown in the example below:

```bash
cmake -B ./build -DAREG_BUILD_EXAMPLES:BOOL=ON
```

Please note that the specific steps and commands may vary depending on the context and environment. It is always recommended to refer to the documentation or support resources provided with the [AREG SDK](https://github.com/aregtech/areg-sdk/) for accurate instructions.

---

## Clone Sources

To clone the AREG SDK Demo repository, follow these steps in your desired directory (such as the `projects` directory):

* Run the following command **to clone the repository and its submodules**:
   ```bash
   git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
   ```

   It is important to clone the AREG SDK *submodule* as well. This command ensures that both the main repository and its submodule are cloned.

* If you have already cloned the main repository but missed cloning the submodule, you can **update the submodules** separately by running the following command:
   ```bash
   git submodule update --init --recursive
   ```

   This command initializes and updates the submodules within the repository.

* The AREG SDK also has dependencies on [Google Unit Test](https://github.com/google/googletest), which is automatically cloned with the AREG SDK sources. **To update to the latest submodule sources**, use the following git command:
   ```bash
   git submodule update --remote --recursive
   ```

   This command updates the submodules, including the Google Unit Test submodule, to the latest version.

---

## Quick Build

The [`CMakeLists.txt`](https://github.com/aregtech/areg-sdk-demo/blob/main/CMakeLists.txt) file provides options to enable or disable various features. You can either pass these options through the command line or make the necessary changes directly in the file.

To quickly build the Demo and integrate the AREG SDK sources with the default options, follow these commands:

1. Initialize the cache:
   ```bash
   cmake -B ./build
   ```
   This command initializes the build configuration cache.

2. Build the applications:
   ```bash
   cmake --build ./build -j 8
   ```
   This command builds the applications using the specified build tool (e.g., CMake or Visual Studio).

In this example, we are building:
- The AREG Framework with subcomponents, specifically the `mcrouter` component.
- Excluding the build of AREG SDK examples.
- Building AREG SDK Unit Tests.

Based on your system's capabilities, adjust the number `8` in the `-j 8` flag to set the maximum number of parallel jobs to be executed during the build process. Ensure that you have the necessary build tools and dependencies installed in your environment before attempting to build the sources.

---

## Demo Examples

The demo examples can be found in the [`./demo/`](https://github.com/aregtech/areg-sdk-demo/tree/main/demo) subdirectory of this repository. In order to keep things simple, we have included a few projects that were taken from the [examples](https://github.com/aregtech/areg-sdk/tree/master/examples) of the AREG SDK. Feel free to explore the existing demo examples and modify them as needed. You can also contribute new examples to showcase different functionalities or use cases of the AREG SDK.

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
