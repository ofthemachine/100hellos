# TinyGo

TinyGo is a Go compiler for small places. It's designed to bring the Go programming language to microcontrollers, WebAssembly, and other environments where traditional Go is too resource-intensive.

## About TinyGo

TinyGo is not just a subset of Go - it's a completely different compiler implementation built on LLVM that targets small devices and embedded systems. While regular Go is excellent for servers and desktop applications, TinyGo excels in:

- **Microcontrollers**: Arduino, Raspberry Pi Pico, micro:bit, ESP32, and many others
- **WebAssembly**: Creating small, fast WASM modules
- **Embedded Systems**: IoT devices, sensors, and real-time applications
- **Static Binaries**: Producing tiny, statically linked executables

## Key Differences from Regular Go

### Smaller Runtime
TinyGo implements a much smaller runtime compared to standard Go:
- No garbage collector (or a very minimal one depending on target)
- Smaller standard library footprint
- Direct hardware access for microcontrollers

### Size Comparison
Where a regular Go "Hello World" might be 2MB+, TinyGo can produce:
- **Microcontrollers**: 1-10KB depending on target
- **WebAssembly**: 1-50KB
- **Linux executables**: 10-100KB

### Compilation Targets
TinyGo supports dozens of microcontroller targets out of the box:
```bash
# Examples of supported targets
tinygo flash -target=arduino main.go
tinygo flash -target=microbit main.go
tinygo flash -target=pico main.go
tinygo build -target=wasm main.go
```

## Language Features

TinyGo supports most Go language features including:
- Goroutines (limited on some targets)
- Channels
- Interfaces
- Closures
- Most standard library packages (subset)

**Note**: Some advanced features like reflection and the full `net/http` package may not be available on all targets.

## Real-World Applications

TinyGo is used in production for:
- **IoT Sensors**: Temperature, humidity, motion sensors
- **Robotics**: Motor controllers, sensor integration
- **Wearables**: Fitness trackers, smartwatches
- **Industrial Control**: PLCs, automation systems
- **Edge Computing**: Lightweight data processing

## Development Workflow

Unlike regular Go development, TinyGo often involves:
1. **Target Selection**: Choosing your hardware platform
2. **Hardware Abstraction**: Using machine package for GPIO, I2C, SPI
3. **Size Optimization**: Keeping code minimal for resource constraints
4. **Cross-Compilation**: Building for different architectures

Example microcontroller code:
```go
package main

import (
    "machine"
    "time"
)

func main() {
    led := machine.LED
    led.Configure(machine.PinConfig{Mode: machine.PinOutput})

    for {
        led.High()
        time.Sleep(500 * time.Millisecond)
        led.Low()
        time.Sleep(500 * time.Millisecond)
    }
}
```

## Further Exploration

- **Official Website**: [tinygo.org](https://tinygo.org/)
- **GitHub Repository**: [github.com/tinygo-org/tinygo](https://github.com/tinygo-org/tinygo)
- **Hardware Drivers**: [tinygo.org/x/drivers](https://pkg.go.dev/tinygo.org/x/drivers)
- **Examples**: [github.com/tinygo-org/tinygo/tree/release/src/examples](https://github.com/tinygo-org/tinygo/tree/release/src/examples)
- **Supported Boards**: [tinygo.org/docs/reference/microcontrollers/](https://tinygo.org/docs/reference/microcontrollers/)

TinyGo opens up the world of embedded programming to Go developers, bringing familiar syntax and powerful features to the smallest of devices.