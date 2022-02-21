// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import Foundation

enum Decimal {
  static let upperLimit: [Int: Int64] = [
    2: 9,
    3: 9,
    4: 99,
    5: 99,
    6: 999,
    7: 999,
    8: 9999,
    9: 9999,
    10: 99999,
    11: 99999,
    12: 999999,
    13: 999999,
    14: 9999999,
    15: 9999999,
    16: 99999999,
    17: 99999999,
    18: 999999999,
    19: 999999999,
    20: 9999999999
  ]
  
  static let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  // no middle digit
  static func makeEvenPalindrome(
    highHalfStart: Int64,
    highHalfEnd: Int64,
    numOfDigits: Int
  ) {
    assert(numOfDigits % 2 == 0)
    assert(highHalfStart >= pow(10, numOfDigits / 2 - 1))
    assert(highHalfEnd <=  upperLimit[numOfDigits]!)
    
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
    assert(highHalfStart >= pow(10, numOfDigits / 2 - 1))
    assert(highHalfEnd <=  upperLimit[numOfDigits]!)
    
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
