import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

    func testPart1() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "6440")
    }

    func testPart2() throws {
        let challenge = Day07(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "5905")
    }
}
