import CoreFoundation
import Foundation

let step: Int64 = 10_000_000
let start = Date()
print(Int64.max / step)
var count = 0
for i in Int64(Int32.max)..<Int64.max {
  let decimalPalindrome = "1\(i)1"
  let n = Int64(decimalPalindrome)!
  count += Binary.isPalindromLookup(n) ? 1 : 0
  if (i % step) == 0 {
    let ellapsedSeconds = Date().timeIntervalSince(start)
    let rate = Double(i - Int64(Int32.max)) / ellapsedSeconds
    print("\(ellapsedSeconds): \(i),   rate = \(round(rate)) / sec  \(count)")
  }
}
