@testable import palindrome2
import XCTest

final class palindrom2Tests: XCTestCase {
  func testNaiveBinaryPalindrom() {
    isBinaryPalindromeTest(isPalindrome: Binary.isPalindrome)
  }

  func testNaiveBinaryPalindromLookup() {
    isBinaryPalindromeTest(isPalindrome: Binary.isPalindromeLookup)
  }

  func isBinaryPalindromeTest(isPalindrome: (Int64) -> Bool) {
    let p0: Int64 = 0b1
    let p1: Int64 = 0b10001
    let p2: Int64 = 0b10101
    let p3: Int64 = 0b100001
    let p4: Int64 = 0b101101
    let p5: Int64 = 1979791
    let p6: Int64 = 7451111547
    let p7: Int64 = Int64.max
    XCTAssertEqual(isPalindrome(p0), true)
    XCTAssertEqual(isPalindrome(p1), true)
    XCTAssertEqual(isPalindrome(p2), true)
    XCTAssertEqual(isPalindrome(p3), true)
    XCTAssertEqual(isPalindrome(p4), true)
    XCTAssertEqual(isPalindrome(p5), true)
    XCTAssertEqual(isPalindrome(p6), true)
    XCTAssertEqual(isPalindrome(p7), true)

    let np0: Int64 = 0b10
    let np1: Int64 = 0b10011
    let np2: Int64 = 0b11101
    let np3: Int64 = 0b101001
    let np4: Int64 = 0b100101
    let np5: Int64 = 1978791
    let np6: Int64 = 74512321547
    let np7: Int64 = Int64.max - 1
    XCTAssertEqual(isPalindrome(np0), false)
    XCTAssertEqual(isPalindrome(np1), false)
    XCTAssertEqual(isPalindrome(np2), false)
    XCTAssertEqual(isPalindrome(np3), false)
    XCTAssertEqual(isPalindrome(np4), false)
    XCTAssertEqual(isPalindrome(np5), false)
    XCTAssertEqual(isPalindrome(np6), false)
    XCTAssertEqual(isPalindrome(np7), false)
  }
}
