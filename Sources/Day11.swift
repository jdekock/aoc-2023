import Algorithms
import Foundation

struct Day11: AdventDay {
    var data: String
    
    func part1() -> Any {
        let map = data.split(separator: "\n").map({ Array($0) })
        return calculateSteps(map: map, expansion: 1)
    }

    func part2() -> Any {
        let map = data.split(separator: "\n").map({ Array($0) })
        return calculateSteps(map: map, expansion: 999999)
    }
    
    func calculateSteps(map: [[Character]], expansion: Int) -> Int {
        // find empty rows and columns
        let emptyRows = map.enumerated().filter({ $0.element.allSatisfy({ $0 == "." }) }).map({ $0.offset })
        var emptyColumns: [Int] = []
        for i in 0..<map[0].count {
            if map.map({ $0[i] }).allSatisfy({ $0 == "." }) {
                emptyColumns.append(i)
            }
        }
        
        // find galaxy positions in the map
        var galaxyPositions: [(Int, Int)] = []
        for y in 0..<map.count {
            for x in 0..<map[y].count {
                if map[y][x] == "#" {
                    galaxyPositions.append((y,x))
                }
            }
        }
        
        // find route to all next galaxies from current
        var steps = 0
        for i in 0..<galaxyPositions.count {
            for n in i+1..<galaxyPositions.count {
                steps += (galaxyPositions[n].0 - galaxyPositions[i].0) + (max(galaxyPositions[n].1,galaxyPositions[i].1) - min(galaxyPositions[n].1,galaxyPositions[i].1))
                
                // add steps if route crosses empty row
                for row in galaxyPositions[i].0...galaxyPositions[n].0 {
                    if emptyRows.contains(row) {
                        steps += expansion
                    }
                }
                
                // add steps if route crosses empty column
                for column in min(galaxyPositions[n].1,galaxyPositions[i].1)...max(galaxyPositions[n].1,galaxyPositions[i].1) {
                    if emptyColumns.contains(column) {
                        steps += expansion
                    }
                }
            }
        }
        
        return steps
    }
}
