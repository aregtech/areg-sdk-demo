# AREG SDK Demo Project

---

## Build Status

[![CMake](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml/badge.svg)](https://github.com/aregtech/areg-sdk-demo/actions/workflows/cmake.yml)

---

This repository demonstrates the integration of AREG framework in the projects.

To clone, run:
```bash
git clone --recurse-submodules https://github.com/aregtech/areg-sdk-demo.git
```

To update only submodules:
```bash
git submodule update --init --recursive
```

To update to the latest submodule sources, use the git-command:
```bash
git submodule update --remote --recursive
```

To compile:
```bash
cmake -B ./build
cmake --build ./build -j 8
```
