import Foundation
import Testing
@testable import PerformanceTimer

@Test func start_stop() async throws {
  let reportingUnits: PerformanceTimerReportingUnits = .milliseconds
  var timer = PerformanceTimer(timerReportingUnits: reportingUnits)
  
  timer.start()
  sleep(1)
  print("Stop: \(timer.stop()) \(reportingUnits.label)")

  print("Total: \(timer.total) \(reportingUnits.label)")

  #expect(timer.total >= 1000)
  #expect(reportingUnits.label == "ms")
}

@Test func start_lap_lap_stop() async throws {
  let reportingUnits: PerformanceTimerReportingUnits = .seconds
  var timer = PerformanceTimer(timerReportingUnits: reportingUnits)
  
  timer.start()
  sleep(1)
  print("Lap: \(timer.lap()) \(reportingUnits.label)")
  sleep(2)
  print("Lap: \(timer.lap()) \(reportingUnits.label)")
  sleep(1)
  print("Stop: \(timer.stop()) \(reportingUnits.label)")

  print("Total: \(timer.total) \(reportingUnits.label)")

  #expect(timer.total >= 4)
  #expect(reportingUnits.label == "s")
}
