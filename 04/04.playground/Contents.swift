/*
 Advent Of Code - Day 4
 https://adventofcode.com/2023/day/4
 */

import Foundation

enum ValidationError: Error {
    case fileNotFound
}

class AOC {
    func result(_ input: String) throws -> (Int, Int) {
        guard let fileURL = Bundle.main.url(forResource: input, withExtension: "txt") else { throw ValidationError.fileNotFound }
        let content = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)

        let games = content.split(separator: "\n").map({
            return $0.replacingOccurrences(of: "(Card +[0-9]+:)", with: "", options: [.regularExpression]).split(separator: "|")
                        .map{ $0.replacingOccurrences(of: "  ", with: " ")
                        .split(separator: " ").map({ Int($0) ?? 0 }) }
        })
        
        var gamePoints: [Int] = []
        var cards: [Int: Int] = [:]
        var cardsCount: Int = 0
        
        var gameNumber: Int = 1
        games.forEach { game in
            cards[gameNumber, default: 0] += 1
            let numberMatches = Array(Set(game[0]).intersection(game[1])).count
            gamePoints.append(Int(pow(2.0, Double(numberMatches - 1))))
            
            if numberMatches > 0 {
                for i in 1..<numberMatches + 1 {
                    cards[gameNumber + i, default: 0] += cards[gameNumber] ?? 1
                }
            }
            
            gameNumber += 1
        }
        
        cards.forEach { _, count in
            cardsCount += count
        }
        
        return (gamePoints.reduce(0, +), cardsCount)
    }
}

try AOC().result("test") // return 13, 30
try AOC().result("input") // return 24542, 8736438
