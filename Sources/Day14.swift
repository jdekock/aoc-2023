import Algorithms
import Foundation

struct Day14: AdventDay {
    var data: String

    func part1() -> Any {
        let data = data.split(separator: "\n").map({ Array($0) })
        var map = rollUp(data)
        
        var result = 0
        map = map.reversed()
        for i in 0..<map.count {
            let OCount = map[i].filter({ $0 == "O" }).count
            result += OCount * (i + 1)
        }
        
        return result
    }

    func part2() -> Any {
        var map = data.split(separator: "\n").map({ Array($0) })
        var seenMaps: [[[Character]]] = [map]
        var foundMatch = false
        var offset: Int = 0
        
        while !foundMatch {
            for _ in stride(from: 0, to: 4, by: 1) {
                map = rollUp(map)
                map = rotateMap(map)
            }
            
            if let seenMapIndex = seenMaps.firstIndex(where: { $0 == map }) {
                offset = seenMapIndex
                foundMatch = true
            } else {
                seenMaps.append(map)
            }
        }
        
        let minCycles = (1000000000 - offset) % (seenMaps.count - offset) - 1
        map = seenMaps[offset + minCycles].reversed()
        
        var result = 0
        for i in 0..<map.count {
            let OCount = map[i].filter({ $0 == "O" }).count
            result += OCount * (i + 1)
        }
        
        return result
    }
    
    func rollUp(_ map: [[Character]]) -> [[Character]] {
        var map = map
        map.enumerated().forEach { row in
            row.element.enumerated().forEach { character in
                if character.element == "O", row.offset > 0 {
                    var possiblePos: Int = row.offset
                    while possiblePos > 0 {
                        if map[possiblePos - 1][character.offset] == "." {
                            map[possiblePos][character.offset] = "."
                            map[possiblePos - 1][character.offset] = "O"
                        } else {
                            possiblePos = 0
                        }
                        
                        possiblePos -= 1
                    }
                }
            }
        }
        
        return map
    }
    
    func rotateMap<T>(_ matrix: [[T]]) -> [[T]] {
        if matrix.isEmpty {return matrix}
        var result = [[T]]()
        for index in 0..<matrix.first!.count {
            result.append(matrix.map{$0[index]})
        }
        
        result = result.map({ return $0.reversed() })
        
        return result
    }
}
