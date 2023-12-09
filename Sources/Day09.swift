import Algorithms
import Foundation

struct Day09: AdventDay {
    var data: String

    func part1() -> Any {
        let numbers: [Int] = processData(data, part2: false)
        return numbers.reduce(0, +)
    }

    func part2() -> Any {
        let numbers: [Int] = processData(data, part2: true)
        return numbers.reduce(0, +)
    }
    
    func processData(_ data: String, part2: Bool) -> [Int] {
        let sequences: [[Int]] = data.split(separator: "\n").map({ $0.split(separator: " ").map({ Int($0) ?? 0 }) })
        
        var firstNumbers: [Int] = []
        var lastNumbers: [Int] = []
        
        sequences.forEach { sequence in
            var followingSequences: [[Int]] = []
            followingSequences.append(zip(sequence, sequence.dropFirst()).map { $1 - $0 })
            
            while !(followingSequences.last ?? []).allSatisfy({ $0 == 0 }) {
                let lastSequence = (followingSequences.last ?? [])
                followingSequences.append(zip(lastSequence, lastSequence.dropFirst()).map { $1 - $0 })
            }
            
            var sequenceCount = followingSequences.count - 1
            followingSequences.forEach { sequence in
                if sequenceCount > 0 {
                    followingSequences[sequenceCount - 1].insert((followingSequences[sequenceCount - 1].first ?? 0) - (followingSequences[sequenceCount].first ?? 0), at: 0)
                    followingSequences[sequenceCount - 1].append((followingSequences[sequenceCount - 1].last ?? 0) + (followingSequences[sequenceCount].last ?? 0))
                }
                
                sequenceCount -= 1
            }
            
            firstNumbers.append((sequence.first ?? 0) - (followingSequences[0].first ?? 0))
            lastNumbers.append((sequence.last ?? 0) + (followingSequences[0].last ?? 0))
        }
        
        return part2 ? firstNumbers : lastNumbers
    }
}
