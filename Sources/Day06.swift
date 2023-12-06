import Algorithms
import Foundation

struct Day06: AdventDay {
    var data: String
    
    func part1() -> Any {
        let time: [Int] = data.split(separator: "\n").first?.replacingOccurrences(of: "Time:", with: "").split(separator: " ").map({ return Int($0) ?? 0 }) ?? []
        let distance: [Int] = data.split(separator: "\n").last?.replacingOccurrences(of: "Distance:", with: "").split(separator: " ").map({ return Int($0) ?? 0 }) ?? []
        
        var round = 0
        var distances: [Int] = []
        time.forEach { time in
            distances.append(0)
            for i in 0...time {
                if (time - i) * i > distance[round] {
                    distances[round] += 1
                }
            }
            
            round += 1
        }
        
        return distances.reduce(1, *)
    }

    func part2() -> Any {
        let time: Int = data.split(separator: "\n").first?.replacingOccurrences(of: "Time:", with: "").replacingOccurrences(of: " ", with: "").split(separator: " ").map({ return Int($0) ?? 0 }).first ?? 0
        let distance: Int = data.split(separator: "\n").last?.replacingOccurrences(of: "Distance:", with: "").replacingOccurrences(of: " ", with: "").split(separator: " ").map({ return Int($0) ?? 0 }).first ?? 0

        var optionCount = 0
        for i in 0...time {
            if (time - i) * i > distance {
                optionCount += 1
            }
        }
        
        return optionCount
    }
}
