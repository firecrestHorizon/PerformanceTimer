//
//  firecrestHORIZON.uk
//  🦋 @kieran.firecresthorizon.uk
//
import Foundation

/// A stopwatch timer using DispatchTime for nano-second time resolution
/// The reported values for laps, stop and elapsed times are a `Double` with
///  the time units being set in `timerReportingUnits` when the timer is created.
struct PerformanceTimer {
  private(set) var times: [DispatchTime] = []
  private var isRunning: Bool = false
  let timerReportingUnits: PerformanceTimerReportingUnits
  
  /// Time between the start and stop (or last lap) times
  var total: Double {
    guard let first = times.first, let last = times.last else { return 0.0 }
    return timerReportingUnits.toReportingUnits(from: first.distance(to: last))
  }
  
  /// Array of the lap times
  var laps: [Double] {
    zip(times, times.dropFirst()).map { previous, current in
      timerReportingUnits.toReportingUnits(from: previous.distance(to: current))
    }
  }
  
  /// Elapsed time from the start time to .now() or the stop time if the timer has been stopped
  var elapsed: Double {
    guard let startTime = times.first else { return 0.0 }
    let endTime = isRunning ? DispatchTime.now() : times.last!
    
    return timerReportingUnits.toReportingUnits(from: startTime.distance(to: endTime))
  }
  
  init(timerReportingUnits: PerformanceTimerReportingUnits = .nanoseconds) {
    self.timerReportingUnits = timerReportingUnits
  }
  
  /// Clear the previous times, record the start time and set the timer as running
  mutating func start() {
    reset()
    _ = lap()
  }
  
  /// Record the lap time, then calculate the interval from the previous start/lap and return the value
  mutating func lap() -> Double {
    isRunning = true
    let lapTime = DispatchTime.now()
    guard let previousTime = times.last else {
      times.append(lapTime)
      return 0.0
    }
    times.append(lapTime)
    return timerReportingUnits.toReportingUnits(from: previousTime.distance(to: lapTime))
  }
  
  /// Record the stop time, set the timer to stopped, then calculate the interval from the previous start/lap and return the value
  mutating func stop() -> Double {
    let lapTime = lap()
    isRunning = false
    return lapTime
  }
  
  /// Stop the timer and clear stored lap times
  mutating func reset() {
    isRunning = false
    times.removeAll()
  }
}

enum PerformanceTimerReportingUnits {
  case seconds, milliseconds, microseconds, nanoseconds
  
  var label: String {
    switch self {
    case .seconds:      return "s"
    case .milliseconds: return "ms"
    case .microseconds: return "μs"
    case .nanoseconds:  return "ns"
    }
  }
  
  /// Convert a `DispatchTimeInterval` to a time interval units of this enum
  func toReportingUnits(from interval: DispatchTimeInterval) -> Double {
    switch interval {
    case .seconds(let val), .milliseconds(let val), .microseconds(let val), .nanoseconds(let val):
      return Double(val) * interval.intervalMultiplier / nanoSecondsMultiplier
    case .never:
      return 0.0
    @unknown default:
      return 0.0
    }
  }
  
  /// Time unit conversion multipliers
  private var nanoSecondsMultiplier: Double {
    switch self {
    case .seconds:      return 1_000_000_000
    case .milliseconds: return 1_000_000
    case .microseconds: return 1_000
    case .nanoseconds:  return 1
    }
  }
}