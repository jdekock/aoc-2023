import Algorithms
import Foundation

struct Day04: AdventDay {
    var data: String
    
    func part1() -> Any {
        let games = data.split(separator: "\n").map({
            return $0.replacingOccurrences(of: "(Card +[0-9]+:)", with: "", options: [.regularExpression]).split(separator: "|")
                        .map{ $0.replacingOccurrences(of: "  ", with: " ")
                        .split(separator: " ").map({ Int($0) ?? 0 }) }
        })
        
        var gamePoints: [Int] = []
        var gameNumber: Int = 1
        
        games.forEach { game in
            let numberMatches = Array(Set(game[0]).intersection(game[1])).count
            gamePoints.append(Int(pow(2.0, Double(numberMatches - 1))))
            
            gameNumber += 1
        }
        
        return gamePoints.reduce(0, +)
    }

    func part2() -> Any {
        let games = data.split(separator: "\n").map({
            return $0.replacingOccurrences(of: "(Card +[0-9]+:)", with: "", options: [.regularExpression]).split(separator: "|")
                        .map{ $0.replacingOccurrences(of: "  ", with: " ")
                        .split(separator: " ").map({ Int($0) ?? 0 }) }
        })
        
        var cards: [Int: Int] = [:]
        var cardsCount: Int = 0
        var gameNumber: Int = 1
        
        games.forEach { game in
            cards[gameNumber, default: 0] += 1
            let numberMatches = Array(Set(game[0]).intersection(game[1])).count
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
        
        return cardsCount
    }
}
