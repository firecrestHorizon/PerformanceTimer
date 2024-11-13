//
//  firecrestHORIZON.uk
//  🦋 @kieran.firecresthorizon.uk
//

import Foundation

extension PerformanceTimer {
  mutating func measureAsync<T>(_ operation: () async throws -> T) async rethrows -> (result: T, duration: Double) {
    start()
    let result = try await operation()
    let duration = stop()
    return (result, duration)
  }
}
