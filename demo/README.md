# Demos

```
This file is part of AREG SDK demo
Copyright (c) 2022-2023, Aregtech
Contact: info[at]aregtech.com
Website: https://www.aregtech.com
```

## Quick Build

The AREG SDK provides a collection of demos that showcase the how to integrate AREG Framework in the projects. 

Please note that examples labeled as **IPC** (Inter-Process Communication) require the utilization of [_mcrouter_](https://github.com/aregtech/areg-sdk/tree/master/framework/mcrouter) and involve _Public_ services. To successfully test IPC applications, ensure that `mcrouter` is running. Examples not marked as **IPC** only involve _Local_ services and do not require `mcrouter` usage.

To compile the examples, you must first build the _areg_ library and _mcrouter_. The examples can be built using `cmake`, `make`, or `msbuild`. To enable or disable the building of examples, utilize the `AREG_BUILD_EXAMPLES` option in `make` or `cmake`. By default, it is enabled. To disable it, set it to `OFF` or `0`.

Example of quick build using `cmake`:
```bash
cmake -B ./build
cmake --build ./build -j 8
```

Example of quick build using `msbuild`:
```bash
msbuild .
```

For more detailed information about the build process and the supported options, refer to the [Software-build](https://github.com/aregtech/areg-sdk/wiki/03.-Software-build) Wiki page of the AREG SDK.

---

# List of Demos

Here is a list of demos available in the AREG SDK:

1. [01_hello](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/01_hello) - A multithreading console application that outputs the "Hello World" message.
2. [04_trace](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/04_trace) - A multithreading console application for starting and using logging.
3. [05_timer](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/05_timer) - A multithreading console application for starting the Timer Service and using various timers.
4. [10_locsvc](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/10_locsvc) - A multithreading console application demonstrating a _Local_ servicing component.
5. [12_pubsvc](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/12_pubsvc) - A multiprocessing (**IPC**) application demonstrating a _Public_ service and the service client.
6. [16_pubfsm](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/16_pubfsm) - A multiprocessing (**IPC**) application demonstrating the work of a Finite State-Machine (FSM) using AREG framework features.
7. [17_winchat](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/17_winchat) - A Windows GUI application (**IPC**) demonstrating dynamic modeling, fault tolerance, and a distributed system.
8. [19_pubwatchdog](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/19_pubwatchdog) - A multiprocessing (**IPC**) application demonstrating the watchdog feature with a local service.
9. [21_pubunblock](https://github.com/aregtech/areg-sdk-demo/tree/main/demo/21_pubunblock) - A multiprocessing (**IPC**) application demonstrating manual unblocking of requests to process more pending requests.

Please note that the list may be updated periodically. We recommend checking the list regularly.

For more details about each project, refer to t6he _ReadMe.md_ file of each demo project.