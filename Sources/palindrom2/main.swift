import CoreFoundation
import Foundation
print("Hello, world!")

let step: UInt64 = 1_000_000_000
let start = Date()
print(UInt64.max / step)
for i in 0..<UInt64.max {
  if (i % step) == 0 {
    let ellapsedSeconds = Date().timeIntervalSince(start)
    let rate = Double(i) / ellapsedSeconds
    print("\(ellapsedSeconds): \(i),   rate = \(round(rate)) / sec")
  }
}
