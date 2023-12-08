import XCTest

@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
        """

    func testPart1() throws {
        let challenge = Day08(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "2")
    }
    
    let testData2 = """
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
        """

    func testPart2() throws {
        let challenge = Day08(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "6")
    }
}
