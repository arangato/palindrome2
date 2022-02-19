@testable import palindrom2
import XCTest

final class palindrom2Tests: XCTestCase {
  func testBinaryPalindrom() {
    let p0: Int64 = 0b1
    let p1: Int64 = 0b10001
    let p2: Int64 = 0b10101
    let p3: Int64 = 0b100001
    let p4: Int64 = 0b101101
    let p5: Int64 = Int64.max
    XCTAssertEqual(isBinaryPalindrom(p0), true)
    XCTAssertEqual(isBinaryPalindrom(p1), true)
    XCTAssertEqual(isBinaryPalindrom(p2), true)
    XCTAssertEqual(isBinaryPalindrom(p3), true)
    XCTAssertEqual(isBinaryPalindrom(p4), true)
    XCTAssertEqual(isBinaryPalindrom(p5), true)

    let np0: Int64 = 0b10
    let np1: Int64 = 0b10011
    let np2: Int64 = 0b11101
    let np3: Int64 = 0b101001
    let np4: Int64 = 0b100101
    let np5: Int64 = Int64.max - 1
    XCTAssertEqual(isBinaryPalindrom(np0), false)
    XCTAssertEqual(isBinaryPalindrom(np1), false)
    XCTAssertEqual(isBinaryPalindrom(np2), false)
    XCTAssertEqual(isBinaryPalindrom(np3), false)
    XCTAssertEqual(isBinaryPalindrom(np4), false)
    XCTAssertEqual(isBinaryPalindrom(np5), false)
  }
}
