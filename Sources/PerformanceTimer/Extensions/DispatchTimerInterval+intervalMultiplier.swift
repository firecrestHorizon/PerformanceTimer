//
//  firecrestHORIZON.uk
//  🦋 @kieran.firecresthorizon.uk
//

import Foundation

extension DispatchTimeInterval {
  internal var intervalMultiplier: Double {
    switch self {
    case .seconds:      return 1_000_000_000
    case .milliseconds: return 1_000_000
    case .microseconds: return 1_000
    case .nanoseconds:  return 1
    case .never:        return 0.0
    @unknown default:   return 0.0
    }
  }
}
