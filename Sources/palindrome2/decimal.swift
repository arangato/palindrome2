// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import Foundation

/// halfDigitsCount > 0
func makePalindrome(halfDigitsCount: Int) {
  let middleDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  var start = 1
  var upperEnd = 9
  for _ in 1..<halfDigitsCount {
    upperEnd = upperEnd * 10 + 9
    start *= 10
  }

  let step: Int64 = 1_000_000
  let startTime = Date()
  var count = Int64(0)
  var found = 0

  let format = "%0\(halfDigitsCount)d"
  // no middle digit
  for m in start...upperEnd {
    let high = String(format: format, m)
    let low = String(high.reversed())
    let p = "\(high)\(low)"
    
    count += 1
    let i = Int64(p)!
    found += Binary.isPalindromeLookup(i) ? 1 : 0
    if (count % step) == 0 {
      let ellapsedSeconds = Date().timeIntervalSince(startTime)
      let rate = Double(count) / ellapsedSeconds
      print("\(ellapsedSeconds): \(i),   rate = \(round(rate)) / sec  \(found)")
    }
  }

  for m in start...upperEnd {
    for middle in middleDigits {
      let high = String(format: format, m)
      let low = String(high.reversed())
      let p = "\(high)\(middle)\(low)"

      count += 1
      let i = Int64(p)!
      found += Binary.isPalindromeLookup(i) ? 1 : 0
      if (count % step) == 0 {
        let ellapsedSeconds = Date().timeIntervalSince(startTime)
        let rate = Double(count) / ellapsedSeconds
        print("\(ellapsedSeconds): \(i),   rate = \(round(rate)) / sec  \(found)")
      }
    }
  }
}
