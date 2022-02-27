//
//  File.swift
//  
//
//  Created by Maxim Grabarnik on 27/02/2022.
//

import Foundation

struct BackwardDecimal {
  private var digits: [UInt8]
  
  let mostSignifcantDigit: UInt64
  
  private(set) var value: UInt64
  
  init(digits: [UInt8]) {
    self.digits = digits
    mostSignifcantDigit = Decimal.pow(10, digits.count - 1)
    var msd = mostSignifcantDigit
    value = 0
    for i in (0..<digits.count).reversed() {
      value += UInt64(digits[i]) * msd
      msd /= 10
    }
  }
  
  init(_ n: UInt64, digitsCount: Int) {
    var digits = [UInt8]()
    var n = n
    for _ in 0..<digitsCount {
      digits.append(UInt8(n % 10))
      n /= 10
    }
    self.init(digits: digits)
  }
  
  mutating func backwardsInc() {
    var msd = mostSignifcantDigit
    for i in (0..<digits.count).reversed() {
      if digits[i] < 9 {
        digits[i] += 1
        value += msd
        return
      }
      value -= UInt64(digits[i]) * msd
      digits[i] = 0
      msd /= 10
    }
  }
}
