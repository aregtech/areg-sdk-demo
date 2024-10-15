# dummy Overview

This project is required only to call the `demo_generate.bat` script located in the `<areg-sdk-demo>/demo` directory. The script should run as a pre-build action to generate files from `.siml` Service Interface files. The scrip receive 2 parameters:
- The root directory of `<areg-sdk>` (parameter `$(AregSdkRoot)`), required to access the `codegen.jar`;
- The output directory to write generated files.

The generated files are included in each `xx_generate` project of Demo.
Right now, there is no automated way to create `*.vcxproj` MSVC project files and update the `*.sln` MSVC solution file. The `xx_generate` projects should be manually created and the generated files should be manually included in the `xx_generate.vcxproj` files. Unlike build with Microsoft Visual Studio and MSBuild, the build with CMake automated this process.
