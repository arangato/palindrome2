// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import BigNumber
import Foundation

enum Decimal {
  static let range = [
    2:            1...9,
    3:            1...9,
    4:           10...99,
    5:           10...99,
    6:          100...999,
    7:          100...999,
    8:         1000...9999,
    9:         1000...9999,
    10:       10000...99999,
    11:       10000...99999,
    12:      100000...999999,
    13:      100000...999999,
    14:     1000000...9999999,
    15:     1000000...9999999,
    16:    10000000...99999999,
    17:    10000000...99999999,
    18:   100000000...999999999,
    19:   100000000...999999999,
    20:  1000000000...9999999999,
    21:  1000000000...9999999999,
    22: 10000000000...99999999999,
    23: 10000000000...99999999999
  ]

  static func makePalindrome(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))

    if numOfDigits.isOdd {
      return makeOddPalindromeArithmetic(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    } else {
      return makeEvenPalindromeArithmetic(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    }
  }
  
  // MARK: Stupid string based palindrome generator

  // no middle digit
  static func makeEvenPalindrome(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(numOfDigits % 2 == 0)
    
    var results = [String]()

    let format = "%0\(numOfDigits/2)d"
    for m in highHalfStart...highHalfEnd {
      let high = String(format: format, m)
      let low = String(high.reversed())
      let p = "\(high)\(low)"
      let n = UInt64(p)!
      if Binary.isPalindromeLookup(n) {
        results.append(n.description)
      }
    }
    
    return results
  }
  
  static let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  static func makeOddPalindrome(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String>  {
    assert(numOfDigits.isOdd)

    var results = [String]()

    let format = "%0\(numOfDigits/2)d"
    for m in highHalfStart...highHalfEnd {
      for middle in digits {
        let high = String(format: format, m)
        let low = String(high.reversed())
        let p = "\(high)\(middle)\(low)"
        let n = UInt64(p)!
        if Binary.isPalindromeLookup(n) {
          results.append(n.description)
        }
      }
    }
    
    return results
  }
  
  // MARK: arythmetic palindrome generator

  // no middle digit
  static func makeEvenPalindromeArithmetic(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(numOfDigits % 2 == 0)
    
    var results = [String]()

    let halfDigits = numOfDigits / 2
    let factor = pow(UInt64(10), halfDigits)
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    for high in highHalfStart...highHalfEnd {
      let n = high * factor + low.value
      if Binary.isPalindromeLookup(n) {
        results.append(n.description)
      }
      low.backwardsInc()
    }
    
    return results
  }
  
  static func makeOddPalindromeArithmetic(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String>  {
    assert(numOfDigits.isOdd)

    var results = [String]()

    let halfDigits = numOfDigits / 2
    let middleFactor = pow(UInt64(10), halfDigits)
    let highFactor = middleFactor * 10
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    for high in highHalfStart...highHalfEnd {
      let highAndLow = high * highFactor + low.value
      for middle in 0...9 {
        let n = highAndLow + UInt64(middle) * middleFactor
        if Binary.isPalindromeLookup(n) {
          results.append(n.description)
        }
      }
      low.backwardsInc()
    }
    
    return results
  }
  
  @inline(__always)
  static func reverseDigits(_ n: UInt64, digits: Int) -> UInt64 {
    var n = n
    var result = UInt64(0)
    for _ in 0..<digits {
      result = result * 10 + n % 10
      n /= 10
    }
    return result
  }
  
  static func pow<N: Numeric>(_ a: N, _ p: Int) -> N {
    guard p > 0 else { return 1 }
    return a * pow(a, p - 1)
  }
  
  // MARK: BigInt

  static func makePalindrome(
    highHalfStart: BInt,
    highHalfEnd: BInt,
    numOfDigits: Int
  ) -> Array<String> {
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))

    if numOfDigits.isOdd {
      return makeOddPalindrome(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    } else {
      return makeEvenPalindrome(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    }
  }
  
  // no middle digit
  static func makeEvenPalindrome(
    highHalfStart: BInt,
    highHalfEnd: BInt,
    numOfDigits: Int
  ) -> Array<String> {
    assert(numOfDigits % 2 == 0)
    
    var results = [String]()

    let halfDigits = numOfDigits / 2
    let factor = pow(BInt.ten, halfDigits)
    var highPart = highHalfStart * factor
    for high in highHalfStart...highHalfEnd {
      let low = reverseDigits(high, digits: halfDigits)
      let n = highPart + low
      if Binary.isPalindrome(n) {
        results.append(n.description)
      }
      highPart += factor
    }
    
    return results
  }

  static func makeOddPalindrome(
    highHalfStart: BInt,
    highHalfEnd: BInt,
    numOfDigits: Int
  ) -> Array<String>  {
    assert(numOfDigits.isOdd)

    var results = [String]()

    let halfDigits = numOfDigits / 2
    let middleFactor = pow(BInt.ten, halfDigits)
    let highFactor = middleFactor * 10
    var highPart = highHalfStart * highFactor
    for high in highHalfStart...highHalfEnd {
      let low = reverseDigits(high, digits: halfDigits)
      let highAndLow = highPart + low
      var middle = BInt.zero
      for _ in 0...9 {
        let n = highAndLow + middle
        if Binary.isPalindrome(n) {
          results.append(n.description)
        }
        middle += middleFactor
      }
      highPart += highFactor
    }
    
    return results
  }

  // MARK: BInt with backward decimal

  static func makePalindromeBInt(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))

    if numOfDigits.isOdd {
      return makeOddPalindromeBInt(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    } else {
      return makeEvenPalindromeBInt(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    }
  }
  
  // no middle digit
  static func makeEvenPalindromeBInt(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(numOfDigits % 2 == 0)
    
    var results = [String]()

    let halfDigits = numOfDigits / 2
    let factor = BInt(pow(UInt64(10), halfDigits))
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    var highPart = BInt(highHalfStart) * factor
    for _ in highHalfStart...highHalfEnd {
      let n = highPart + BInt(low.value)
      if Binary.isPalindrome(n) {
        results.append(n.description)
      }
      highPart += factor
      low.backwardsInc()
    }
    
    return results
  }

  static func makeOddPalindromeBInt(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String>  {
    assert(numOfDigits.isOdd)

    var results = [String]()

    let halfDigits = numOfDigits / 2
    let middleFactor = BInt(pow(UInt64(10), halfDigits))
    let highFactor = middleFactor * 10
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    var highPart = BInt(highHalfStart) * highFactor
    for _ in highHalfStart...highHalfEnd {
      let highAndLow = highPart + BInt(low.value)
      var middle = BInt.zero
      for _ in 0...9 {
        let n = highAndLow + middle
        if Binary.isPalindrome(n) {
          results.append(n.description)
        }
        middle += middleFactor
      }
      highPart += highFactor
      low.backwardsInc()
    }
    
    return results
  }

  // MARK: UInt128 with backward decimal

  static func makePalindromeUInt128(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(range[numOfDigits]!.contains(Int(highHalfStart)))
    assert(range[numOfDigits]!.contains(Int(highHalfEnd)))

    if numOfDigits.isOdd {
      return makeOddPalindromeUInt128(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    } else {
      return makeEvenPalindromeUInt128(
        highHalfStart: highHalfStart,
        highHalfEnd: highHalfEnd,
        numOfDigits: numOfDigits
      )
    }
  }
  
  // no middle digit
  static func makeEvenPalindromeUInt128(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String> {
    assert(numOfDigits % 2 == 0)
    
    var results = [String]()

    let halfDigits = numOfDigits / 2
    let factor = UInt128(upperBits: 0, lowerBits: pow(UInt64(10), halfDigits))
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    var highPart = UInt128(upperBits: 0, lowerBits:highHalfStart) * factor
    for _ in highHalfStart...highHalfEnd {
      let n = highPart + UInt128(upperBits: 0, lowerBits: low.value)
      if Binary.isPalindrome(n) {
        results.append(n.description)
      }
      highPart += factor
      low.backwardsInc()
    }
    
    return results
  }

  static func makeOddPalindromeUInt128(
    highHalfStart: UInt64,
    highHalfEnd: UInt64,
    numOfDigits: Int
  ) -> Array<String>  {
    assert(numOfDigits.isOdd)

    var results = [String]()

    let halfDigits = numOfDigits / 2
    let middleFactor = UInt128(upperBits: 0, lowerBits: pow(UInt64(10), halfDigits))
    let highFactor = middleFactor * 10
    var low = BackwardDecimal(
      reverseDigits(highHalfStart, digits: halfDigits),
      digitsCount: halfDigits
    )
    var highPart = UInt128(upperBits: 0, lowerBits:highHalfStart) * highFactor
    for _ in highHalfStart...highHalfEnd {
      let highAndLow = highPart + UInt128(upperBits: 0, lowerBits: low.value)
      var middle = UInt128(0)
      for _ in 0...9 {
        let n = highAndLow + middle
        if Binary.isPalindrome(n) {
          results.append(n.description)
        }
        middle += middleFactor
      }
      highPart += highFactor
      low.backwardsInc()
    }
    
    return results
  }

  @inline(__always)
  static func reverseDigits(_ n: BInt, digits: Int) -> BInt {
    var n = n
    var result = BInt.zero
    for _ in 0..<digits {
      result = result * 10 + n % 10
      n /= 10
    }
    return result
  }
}

extension Int {
  var isOdd: Bool { self & 1 == 1 }
}

extension BInt {
  static let ten = BInt("10", radix: 10)!
  static let zero = BInt("0", radix: 10)!
  static let nine = BInt("9", radix: 10)!

  func digit(_ n: Int) -> Int {
    Int(self / Decimal.pow(10, n - 1) % 10)
  }
}

extension UInt64 {
  func digit(_ n: Int) -> Int {
    Int(self / Decimal.pow(10, n - 1) % 10)
  }
}
