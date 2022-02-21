import CoreFoundation
import Foundation

func printDecimal(_ n: UInt16) {
  var s = ""
  var nn = n
  for _ in 0...3 {
    s += String(nn >> 12 - 6)
    nn <<= 4
  }

  print(String(format:"%04X", n) + ": " + s)
}

for i in UInt16(0)...UInt16(9000) {
  printDecimal((0x6666 + i) | 0x6666)
}
