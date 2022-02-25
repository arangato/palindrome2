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
    let r1 = Decimal.reverseDigits(1234567, digits: 7)
    XCTAssertEqual(r1, 7654321)

    let r2 = Decimal.reverseDigits(12345, digits: 7)
    XCTAssertEqual(r2, 5432100)

    let r3 = Decimal.reverseDigits(1234500, digits: 7)
    XCTAssertEqual(r3, 54321)

    let r4 = Decimal.reverseDigits(1234567, digits: 3)
    XCTAssertEqual(r4, 765)
  }
}
