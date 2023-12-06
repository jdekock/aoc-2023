import Algorithms
import Foundation

struct Day02: AdventDay {
    var data: String
    
    func part1() -> Any {
        let games = data.split(separator: "\n")

        let maxCubes: [String: Int] = ["red": 12, "green": 13, "blue": 14]
        var possibleGames: [Int] = []
        let regex = try! NSRegularExpression(pattern: "(\\d+)\\s*red|(\\d+)\\s*green|(\\d+)\\s*blue")
        var gameCount = 1
        
        games.forEach { gameInput in
            let sets = gameInput.split(separator: ";")
            var gamePossible = true
            
            sets.forEach { set in
                let gameData = regex.matches(in: String(set), range: NSRange(set.startIndex..., in: set))
                gameData.forEach { result in
                    let marbles = String(set[Range(result.range, in: set)!]).split(separator: " ")
                    let marbleCount = Int(marbles[0]) ?? 0
                    let marbleColor = String(marbles[1])

                    if marbleCount > maxCubes[marbleColor] ?? 0 {
                        gamePossible = false
                    }
                }
            }
            
            if gamePossible {
                possibleGames.append(gameCount)
            }
            
            gameCount += 1
        }
        
        return possibleGames.reduce(0, +)
    }

    func part2() -> Any {
        let games = data.split(separator: "\n")
        
        var minCubes: [Int: [String: Int]] = [:]
        let regex = try! NSRegularExpression(pattern: "(\\d+)\\s*red|(\\d+)\\s*green|(\\d+)\\s*blue")
        var gameCount = 1
        
        games.forEach { gameInput in
            minCubes[gameCount] = ["red": 1, "green": 1, "blue": 1]
            let sets = gameInput.split(separator: ";")
            sets.forEach { set in
                let gameData = regex.matches(in: String(set), range: NSRange(set.startIndex..., in: set))
                gameData.forEach { result in
                    let marbles = String(set[Range(result.range, in: set)!]).split(separator: " ")
                    let marbleCount = Int(marbles[0]) ?? 0
                    let marbleColor = String(marbles[1])
                    let currentCount = minCubes[gameCount]?[marbleColor] ?? 0
                    
                    minCubes[gameCount]?[marbleColor] = max(currentCount, marbleCount)
                }
            }

            gameCount += 1
        }
        
        var powers: [Int] = []
        minCubes.forEach { _, v in
            powers.append((v["red"] ?? 1) * (v["green"] ?? 1) * (v["blue"] ?? 1))
        }
        
        return powers.reduce(0, +)
    }
}
