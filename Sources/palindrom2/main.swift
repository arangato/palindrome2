import CoreFoundation
import Foundation
print("Hello, world!")


let step: Int64 = 100_000_000
let start = Date()
print(Int64.max / step)
var count = 0
for i in Int64(Int32.max)..<Int64.max {
  count += isBinaryPalindrom(i) ? 1 : 0
  if (i % step) == 0 {
    let ellapsedSeconds = Date().timeIntervalSince(start)
    let rate = Double(i) / ellapsedSeconds
    print("\(ellapsedSeconds): \(i),   rate = \(round(rate)) / sec  \(count)")
  }
}
