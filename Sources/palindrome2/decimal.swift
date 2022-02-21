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

  let format = "%0\(halfDigitsCount)d"
  // no middle digit
  for m in start...upperEnd {
    let high = String(format: format, m)
    let low = String(high.reversed())
    let p = "\(high)\(low)"
    print(p)
  }

  for m in start...upperEnd {
    for middle in middleDigits {
      let high = String(format: format, m)
      let low = String(high.reversed())
      let p = "\(high)\(middle)\(low)"
      print(p)
    }
  }
}
