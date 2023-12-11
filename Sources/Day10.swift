import Algorithms
import Foundation

struct Day10: AdventDay {
    var data: String
    
    func part1() -> Any {
        let map: [[Character]] = data.split(separator: "\n").map({ Array($0) })
        let route = getRoute(for: map)
        
        return route.count / 2
    }
    
    func part2() -> Any {
        let map: [[Character]] = data.split(separator: "\n").map({ Array($0) })
        let route = getRoute(for: map)
        
        var containedTileCount = 0
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if route.first(where: { $0 == (y, x) }) == nil {
                    let countBefore = route.filter({ $0.0 == y && $0.1 < x && ["L","J","|"].contains(map[$0.0][$0.1]) }).count
                    let countAfter = route.filter({ $0.0 == y && $0.1 > x && ["L","J","|"].contains(map[$0.0][$0.1]) }).count
                    
                    if countBefore % 2 == 1 && countAfter % 2 == 1 {
                        containedTileCount += 1
                    }
                }
            }
        }
        
        return containedTileCount
    }
    
    func getRoute(for map: [[Character]]) -> [(Int,Int)] {
        // Find start position
        var currentY: Int = map.firstIndex(where: { $0.contains("S") }) ?? 0
        var currentX: Int = map[currentY].firstIndex(of: "S") ?? 0
        
        var previousStep: (Int, Int) = (currentY,currentX)
        var nextCharacter: Character = "S"
        
        var route: [(Int,Int)] = []
        route.append((currentY,currentX))
        
        // Find a waypoint on S based on tiles around
        if map[currentY][currentX + 1] == "-" || map[currentY][currentX + 1] == "7" || map[currentY][currentX + 1] == "J" {
            currentX += 1
        } else if map[currentY][currentX - 1] == "-" || map[currentY][currentX - 1] == "F" || map[currentY][currentX - 1] == "L" {
            currentX -= 1
        } else if map[currentY + 1][currentX] == "|" || map[currentY + 1][currentX] == "J" || map[currentY + 1][currentX] == "L" {
            currentY += 1
        } else if map[currentY - 1][currentX] == "|" || map[currentY - 1][currentX] == "7" || map[currentY - 1][currentX] == "F" {
            currentY -= 1
        }
        
        route.append((currentY,currentX))
        nextCharacter = map[currentY][currentX]

        while nextCharacter != "S" {
            switch nextCharacter {
            case "|":
                if previousStep.0 == currentY - 1 {
                    previousStep = (currentY, currentX)
                    currentY += 1
                } else {
                    previousStep = (currentY, currentX)
                    currentY -= 1
                }
            case "-":
                if previousStep.1 == currentX + 1 {
                    previousStep = (currentY, currentX)
                    currentX -= 1
                } else {
                    previousStep = (currentY, currentX)
                    currentX += 1
                }
            case "L":
                if previousStep.1 == currentX + 1 {
                    previousStep = (currentY, currentX)
                    currentY -= 1
                } else {
                    previousStep = (currentY, currentX)
                    currentX += 1
                }
            case "J":
                if previousStep.1 == currentX - 1 {
                    previousStep = (currentY, currentX)
                    currentY -= 1
                } else {
                    previousStep = (currentY, currentX)
                    currentX -= 1
                }
            case "7":
                if previousStep.0 == currentY + 1 {
                    previousStep = (currentY, currentX)
                    currentX -= 1
                } else {
                    previousStep = (currentY, currentX)
                    currentY += 1
                }
            case "F":
                if previousStep.1 == currentX + 1 {
                    previousStep = (currentY, currentX)
                    currentY += 1
                } else {
                    previousStep = (currentY, currentX)
                    currentX += 1
                }
            default:
                nextCharacter = "S"
            }
            
            route.append((currentY,currentX))
            nextCharacter = map[currentY][currentX]
        }
        
        return route
    }
}
