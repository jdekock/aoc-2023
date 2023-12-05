import Foundation

struct Position: Hashable {
    var x: Int
    var y: Int
}

struct NumberPosition: Hashable {
    var number: String
    var positions: [Position]
}

class AOC {
    func result(_ input: String) -> (Int, Int) {
        let fileURL = Bundle.main.url(forResource: input, withExtension: "txt")
        let content = try! String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
        
        let engineMap: [[Character]] = content.split(separator: "\n").map({ return Array($0) })
        var symbolPositions: [Position] = []
        var numbers: [NumberPosition] = []
        
        var foundNumber: String = ""
        var foundNumberCoords: [Position] = []
        
        var partNumbers: [Int] = []
        
        var gears: [Position: [Int]] = [:]
        var gearRatios: [Int] = []
        
        engineMap.enumerated().forEach({ row in
            if !foundNumber.isEmpty {
                numbers.append(NumberPosition(number: foundNumber, positions: foundNumberCoords))
                foundNumber = ""
                foundNumberCoords = []
            }
            
            row.1.enumerated().forEach({ char in
                if char.1.isNumber {
                    foundNumber.append(char.1)
                    foundNumberCoords.append(Position(x: char.0, y: row.0))
                } else if char.1 == "." {
                    if !foundNumber.isEmpty {
                        numbers.append(NumberPosition(number: foundNumber, positions: foundNumberCoords))
                        foundNumber = ""
                        foundNumberCoords = []
                    }
                } else {
                    symbolPositions.append(Position(x: char.0, y: row.0))
                    
                    if !foundNumber.isEmpty {
                        numbers.append(NumberPosition(number: foundNumber, positions: foundNumberCoords))
                        foundNumber = ""
                        foundNumberCoords = []
                    }
                }
            })
        })
        
        numbers.forEach { numberPosition in
            var found = false
            
            numberPosition.positions.forEach { coord in
                if found { return }
                
                let neighbours: [Position] = getNeighbouringCoords(coord)
                if let symbol = Array(Set(symbolPositions).intersection(neighbours)).first {
                    partNumbers.append(Int(numberPosition.number) ?? 0)
                    found = true

                    if engineMap[symbol.y][symbol.x] == "*" {
                        gears[symbol, default: []].append(Int(numberPosition.number) ?? 0)
                    }
                    
                    return
                }
            }
        }
        
        gears.forEach { _, nums in
            if nums.count > 1 {
                gearRatios.append(nums[0] * nums[1])
            }
        }

        return (partNumbers.reduce(0, +), gearRatios.reduce(0, +))
    }
    
    func getNeighbouringCoords(_ coords: Position) -> [Position] {
        let deltas: [(Int, Int)] = [(-1, -1), (-1, 0), (-1, +1), (0, -1), (0, +1), (+1, -1), (+1, 0), (+1, +1)]
        return deltas.map { x, y in
            return Position(x: coords.x + x, y: coords.y + y)
        }
    }
}

AOC().result("test") // return 4361, 467835
AOC().result("input") // return 550064, 85010461
