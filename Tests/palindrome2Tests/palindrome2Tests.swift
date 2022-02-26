import BigNumber
@testable import palindrome2
import XCTest

final class palindrom2Tests: XCTestCase {
  func testNaiveBinaryPalindrom() {
    isBinaryPalindromeTest(isPalindrome: Binary.isPalindrome)
  }

  func testNaiveBinaryPalindromLookup() {
    isBinaryPalindromeTest(isPalindrome: Binary.isPalindromeLookup)
  }

  func isBinaryPalindromeTest(isPalindrome: (UInt64) -> Bool) {
    let p0: UInt64 = 0b1
    let p1: UInt64 = 0b10001
    let p2: UInt64 = 0b10101
    let p3: UInt64 = 0b100001
    let p4: UInt64 = 0b101101
    let p5: UInt64 = 1979791
    let p6: UInt64 = 7451111547
    let p7: UInt64 = UInt64.max
    XCTAssertEqual(isPalindrome(p0), true)
    XCTAssertEqual(isPalindrome(p1), true)
    XCTAssertEqual(isPalindrome(p2), true)
    XCTAssertEqual(isPalindrome(p3), true)
    XCTAssertEqual(isPalindrome(p4), true)
    XCTAssertEqual(isPalindrome(p5), true)
    XCTAssertEqual(isPalindrome(p6), true)
    XCTAssertEqual(isPalindrome(p7), true)

    let np0: UInt64 = 0b10
    let np1: UInt64 = 0b10011
    let np2: UInt64 = 0b11101
    let np3: UInt64 = 0b101001
    let np4: UInt64 = 0b100101
    let np5: UInt64 = 1978791
    let np6: UInt64 = 74512321547
    let np7: UInt64 = UInt64.max - 1
    XCTAssertEqual(isPalindrome(np0), false)
    XCTAssertEqual(isPalindrome(np1), false)
    XCTAssertEqual(isPalindrome(np2), false)
    XCTAssertEqual(isPalindrome(np3), false)
    XCTAssertEqual(isPalindrome(np4), false)
    XCTAssertEqual(isPalindrome(np5), false)
    XCTAssertEqual(isPalindrome(np6), false)
    XCTAssertEqual(isPalindrome(np7), false)
  }
  
  func testReverseDigits() {
    let r1 = Decimal.reverseDigits(UInt64(1234567), digits: 7)
    XCTAssertEqual(r1, 7654321)

    let r2 = Decimal.reverseDigits(UInt64(12345), digits: 7)
    XCTAssertEqual(r2, 5432100)

    let r3 = Decimal.reverseDigits(UInt64(1234500), digits: 7)
    XCTAssertEqual(r3, 54321)

    let r4 = Decimal.reverseDigits(UInt64(1234567), digits: 3)
    XCTAssertEqual(r4, 765)
  }
  
  func testReverseDigitsBInt() {
    let r1 = Decimal.reverseDigits(BInt("1234567", radix: 10)!, digits: 7)
    XCTAssertEqual(r1, BInt("7654321", radix: 10)!)

    let r2 = Decimal.reverseDigits(BInt("12345", radix: 10)!, digits: 7)
    XCTAssertEqual(r2, BInt("5432100", radix: 10)!)

    let r3 = Decimal.reverseDigits(BInt("1234500", radix: 10)!, digits: 7)
    XCTAssertEqual(r3, BInt("54321", radix: 10)!)

    let r4 = Decimal.reverseDigits(BInt("1234567", radix: 10)!, digits: 3)
    XCTAssertEqual(r4, BInt("765", radix: 10)!)

    let r5 = Decimal.reverseDigits(BInt("1234567890123456789012345678901234567890", radix: 10)!, digits: 40)
    XCTAssertEqual(r5, BInt("987654321098765432109876543210987654321", radix: 10)!)
  }
  
 func testBinaryPalindromeBInt() {
    let p0 = BInt("1", radix: 2)!
    let p1 = BInt("10001", radix: 2)!
    let p2 = BInt("10101", radix: 2)!
    let p3 = BInt("100001", radix: 2)!
    let p4 = BInt("101101", radix: 2)!
    let p5 = BInt("1979791", radix: 10)!
    let p6 = BInt("7451111547", radix: 10)!
    let p7 = BInt("\(UInt64.max)", radix: 10)!
    let p8 = BInt("7475703079870789703075747", radix: 10)!
    XCTAssertEqual(Binary.isPalindrome(p0), true)
    XCTAssertEqual(Binary.isPalindrome(p1), true)
    XCTAssertEqual(Binary.isPalindrome(p2), true)
    XCTAssertEqual(Binary.isPalindrome(p3), true)
    XCTAssertEqual(Binary.isPalindrome(p4), true)
    XCTAssertEqual(Binary.isPalindrome(p5), true)
    XCTAssertEqual(Binary.isPalindrome(p6), true)
    XCTAssertEqual(Binary.isPalindrome(p7), true)
    XCTAssertEqual(Binary.isPalindrome(p8), true)

    let np0 = BInt("10", radix: 2)!
    let np1 = BInt("10011", radix: 2)!
    let np2 = BInt("11101", radix: 2)!
    let np3 = BInt("101001", radix: 2)!
    let np4 = BInt("100101", radix: 2)!
    let np5 = BInt("1978791", radix: 10)!
    let np6 = BInt("74512321547", radix: 10)!
    let np7 = BInt("\(UInt64.max - 1)", radix: 10)!
    let np8 = BInt("7475703079871789703075747", radix: 10)!
    XCTAssertEqual(Binary.isPalindrome(np0), false)
    XCTAssertEqual(Binary.isPalindrome(np1), false)
    XCTAssertEqual(Binary.isPalindrome(np2), false)
    XCTAssertEqual(Binary.isPalindrome(np3), false)
    XCTAssertEqual(Binary.isPalindrome(np4), false)
    XCTAssertEqual(Binary.isPalindrome(np5), false)
    XCTAssertEqual(Binary.isPalindrome(np6), false)
    XCTAssertEqual(Binary.isPalindrome(np7), false)
    XCTAssertEqual(Binary.isPalindrome(np8), false)
  }

}
