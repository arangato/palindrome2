// Copyright (c) 2021 Lightricks. All rights reserved.
// Created by Maxim Grabarnik.

import Foundation

// works for non zero numbers.
public func isBinaryPalindrom(_ n: Int64) -> Bool{
  let msbIndex = flsll(n)
  var i = msbIndex - 1
  var j = 0
  while i > j {
    let highBitSet = (n & (1 << i)) > 0
    let lowBitSet = (n & (1 << j)) > 0
    guard highBitSet == lowBitSet else { return false }
    i -= 1
    j += 1
  }

  return true
}
