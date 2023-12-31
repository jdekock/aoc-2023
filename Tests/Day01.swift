import XCTest

@testable import AdventOfCode

final class Day01Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

    func testPart1() throws {
        let challenge = Day01(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "142")
    }
    
    let testData2 = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

    func testPart2() throws {
        let challenge = Day01(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "281")
    }
}
