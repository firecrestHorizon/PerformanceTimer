#  Performance Timer

A high-resolution stopwatch timer for Swift projects, using `DispatchTime` to measure with nanosecond accuracy.

Precise time measurement supporting conversions to alternative time units (seconds, milliseconds, microseconds, and nanoseconds).

## Features
  - Basic stopwatch functions: `start()`, `stop()`, and `reset()`
  - Lap times: Call `lap()` while timer is running to record a lap time
  - Elapsed time: Call `elasped` to get the current timer value without recording a lap time
  
### Example

```swift
// Initialize the timer, setting the reporting units to milliseconds
var timer = PerformanceTimer(reportingUnits: .milliseconds)

// Start the timer
timer.start()

// Simulate some work
usleep(500_000) // 500 milliseconds

// Record a lap time
let firstLap = timer.lap() // Returns lap duration in milliseconds
print("First lap: \(firstLap) \(timer.reportingUnits.label)")

// Simulate more work
usleep(250_000) // 250 milliseconds

// Record another lap
let secondLap = timer.lap()
print("Second lap: \(secondLap) \(timer.reportingUnits.label)")

// Stop the timer
let finalLap = timer.stop()
print("Final lap: \(finalLap) \(timer.reportingUnits.label)")

print("Total duration: \(timer.total) \(timer.reportingUnits.label)")
```

Detailed lap time available from the `laps` array, given in the reporting units ...
```swift
for (index, lap) in timer.laps.enumerated() {
  print("Lap \(index): \(lap) \(timer.reportingUnits.label)")
}
// "Lap 0: 1.005140667 s"
// ...
```

... or get raw `times`, given as an array of `DispatchTime` ...
```swift
for (index, time) in timer.times.enumerated() {
  print("Lap \(index) DispatchTime: \(time)")
}
// "Lap 0 DispatchTime: DispatchTime(rawValue: 5088168112547)"
// ...
```


### Contributing

Feel free to contribute by opening an issue or submitting a pull request. Suggestions, improvements, and additional features are welcome.

### License

This project is licensed under the MIT License. See the LICENSE file for details.

### Contact
 
For questions or support, contact me on BlueSky🦋 @kieran.firecresthorizon.uk.
