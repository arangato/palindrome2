// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import Foundation

enum Decimal {
  static let range = [
    2:           1...9,
    3:           1...9,
    4:          10...99,
    5:          10...99,
    6:         100...999,
    7:         100...999,
    8:        1000...9999,
    9:        1000...9999,
    10:      10000...99999,
    11:      10000...99999,
    12:     100000...999999,
    13:     100000...999999,
    14:    1000000...9999999,
    15:    1000000...9999999,
    16:   10000000...99999999,
    17:   10000000...99999999,
    18:  100000000...999999999,
    19:  100000000...999999999,
    20: 1000000000...9999999999
  ]

  static let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  // no middle digit
  static func makeEvenPalindrome(
    highHalfStart: Int64,
    highHalfEnd: Int64,
    numOfDigits: Int
  ) {
    assert(numOfDigits % 2 == 0)
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))
    
    let format = "%0\(numOfDigits/2)d"
    for m in highHalfStart...highHalfEnd {
      let high = String(format: format, m)
      let low = String(high.reversed())
      let p = "\(high)\(low)"
      print(p)
    }
  }
  
  static func makeOddPalindrome(
    highHalfStart: Int64,
    highHalfEnd: Int64,
    numOfDigits: Int
  ) {
    assert(numOfDigits % 2 == 1)
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))
    let format = "%0\(numOfDigits/2)d"
    for m in highHalfStart...highHalfEnd {
      for middle in digits {
        let high = String(format: format, m)
        let low = String(high.reversed())
        let p = "\(high)\(middle)\(low)"
        print(p)
      }
    }
  }
  
  static func pow(_ a: Int64, _ p: Int) -> Int64 {
    guard p > 0 else { return 1 }
    return 10 * pow(a, p - 1)
  }
}
