@testable import palindrom2
import XCTest

final class palindrom2Tests: XCTestCase {
  func testNaiveBinaryPalindrom() {
    isBinaryPalindromTest(isPalindrom: Binary.isPalindrom)
  }

  func testNaiveBinaryPalindromLookup() {
    isBinaryPalindromTest(isPalindrom: Binary.isPalindromLookup)
  }

  func isBinaryPalindromTest(isPalindrom: (Int64) -> Bool) {
    let p0: Int64 = 0b1
    let p1: Int64 = 0b10001
    let p2: Int64 = 0b10101
    let p3: Int64 = 0b100001
    let p4: Int64 = 0b101101
    let p5: Int64 = 1979791
    let p6: Int64 = 7451111547
    let p7: Int64 = Int64.max
    XCTAssertEqual(isPalindrom(p0), true)
    XCTAssertEqual(isPalindrom(p1), true)
    XCTAssertEqual(isPalindrom(p2), true)
    XCTAssertEqual(isPalindrom(p3), true)
    XCTAssertEqual(isPalindrom(p4), true)
    XCTAssertEqual(isPalindrom(p5), true)
    XCTAssertEqual(isPalindrom(p6), true)
    XCTAssertEqual(isPalindrom(p7), true)

    let np0: Int64 = 0b10
    let np1: Int64 = 0b10011
    let np2: Int64 = 0b11101
    let np3: Int64 = 0b101001
    let np4: Int64 = 0b100101
    let np5: Int64 = 1978791
    let np6: Int64 = 74512321547
    let np7: Int64 = Int64.max - 1
    XCTAssertEqual(isPalindrom(np0), false)
    XCTAssertEqual(isPalindrom(np1), false)
    XCTAssertEqual(isPalindrom(np2), false)
    XCTAssertEqual(isPalindrom(np3), false)
    XCTAssertEqual(isPalindrom(np4), false)
    XCTAssertEqual(isPalindrom(np5), false)
    XCTAssertEqual(isPalindrom(np6), false)
    XCTAssertEqual(isPalindrom(np7), false)
  }
}
