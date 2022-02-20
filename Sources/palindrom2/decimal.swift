// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import Foundation

/// mirrorDigits > 0
/// middleDigit in 0..9
func makePalindrom(mirrorDigits: Int) {
  let middleDigits = ["", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  var upperEnd = 9
  for _ in 1..<mirrorDigits {
    upperEnd = upperEnd * 10 + 9
  }
  let format = "%0\(mirrorDigits)d"
  for middle in middleDigits {
    for i in 1...9 {
      for m in 0...upperEnd {
        let high = String(format: format, m)
        let low = String(high.reversed())
        let p = "\(i)\(high)\(middle)\(low)\(i)"
        print(p)
      }
    }
  }
}
