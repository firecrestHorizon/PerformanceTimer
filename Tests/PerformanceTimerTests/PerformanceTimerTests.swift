import Foundation
import Testing
@testable import PerformanceTimer

@Test func start_stop() async throws {
  var timer = PerformanceTimer(reportingUnits: .milliseconds)
  
  timer.start()
  sleep(1)
  print("Stop: \(timer.stop()) \(timer.reportingUnits.label)")

  print("Total: \(timer.total) \(timer.reportingUnits.label)")

  #expect(timer.total >= 1000)
  #expect(timer.reportingUnits.label == "ms")
}

@Test func start_lap_lap_stop() async throws {
  var timer = PerformanceTimer(reportingUnits: .seconds)
  
  timer.start()
  sleep(1)
  print("Lap: \(timer.lap()) \(timer.reportingUnits.label)")
  sleep(2)
  print("Lap: \(timer.lap()) \(timer.reportingUnits.label)")
  sleep(1)
  print("Stop: \(timer.stop()) \(timer.reportingUnits.label)")

  print("Total: \(timer.total) \(timer.reportingUnits.label)")

  #expect(timer.total >= 4)
  #expect(timer.reportingUnits.label == "s")
  
  
  for (index, lap) in timer.laps.enumerated() {
    print("Lap \(index): \(lap) \(timer.reportingUnits.label)")
  }
  
  for (index, time) in timer.times.enumerated() {
    print("Lap \(index) DispatchTime: \(time)")
  }
}
