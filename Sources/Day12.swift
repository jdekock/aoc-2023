import Algorithms
import Foundation

class Day12: AdventDay {
    var data: String
    var cache: [String: Int] = [:]
    
    required init(data: String) {
        self.data = data
    }
    
    func part1() -> Any {
        let records = data.split(separator: "\n")
        let springGroups: [([Character], [Int])] = records.map({
            let row = $0.split(separator: " ")
            return (Array(row[0]), row[1].split(separator: ",").map({ Int($0) ?? 0 }))
        })
        
        var possibilityCount = 0
        springGroups.forEach { springs, map in
            possibilityCount += checkPossibilities(input: springs, groups: map, currentGroup: 0)
        }

        return possibilityCount
    }
    
    func part2() -> Any {
        let records = data.split(separator: "\n")
        let springGroups: [([Character], [Int])] = records.map({
            let row = $0.split(separator: " ")
            return (Array(row[0]), row[1].split(separator: ",").map({ Int($0) ?? 0 }))
        })
        
        var possibilityCount = 0
        springGroups.forEach { springs, map in
            let extendedSprings = Array(Array(repeating: springs, count: 5).joined(separator: "?"))
            let extendedMap = Array(Array(repeating: map, count: 5).joined())
            
            let possibilities = checkPossibilities(input: extendedSprings, groups: extendedMap, currentGroup: 0)
            possibilityCount += possibilities
        }

        return possibilityCount
    }

    func checkPossibilities(input: [Character], groups: [Int], currentGroup: Int) -> Int {
        if let result = cache[String("\(input)\(groups)\(currentGroup)")] {
            return result
        }
        
        // If no more chars to check, check if result matches groups
        if input.count == 0 {
            if groups.isEmpty, currentGroup == 0 {
                cache[String("\(input)\(groups)\(currentGroup)")] = 1
                return 1
            } else if groups.count == 1, currentGroup == groups[0] {
                cache[String("\(input)\(groups)\(currentGroup)")] = 1
                return 1
            } else {
                cache[String("\(input)\(groups)\(currentGroup)")] = 0
                return 0
            }
        }
        
        // If current group of # is bigger than what's expected it's not a possibility
        if !groups.isEmpty, currentGroup > groups[0] {
            cache[String("\(input)\(groups)\(currentGroup)")] = 0
            return 0
        } else if groups.isEmpty, currentGroup > 0 {
            cache[String("\(input)\(groups)\(currentGroup)")] = 0
            return 0
        }
        
        var count = 0
        let char = input[0]

        // Check if upcoming character can be part of a group
        if char == "#" || char == "?" {
            count += checkPossibilities(input: Array(input.dropFirst()), groups: groups, currentGroup: currentGroup + 1) // extend current group
        }
        
        // Check if delimiter is valid, start a new group if it matches the current group
        if char == "." || char == "?" {
            if !groups.isEmpty, currentGroup == groups[0] {
                count += checkPossibilities(input: Array(input.dropFirst()), groups: Array(groups.dropFirst()), currentGroup: 0)
            } else if currentGroup == 0 { // Already in a new group, extra delimiter
                count += checkPossibilities(input: Array(input.dropFirst()), groups: groups, currentGroup: 0)
            }
        }
        
        cache[String("\(input)\(groups)\(currentGroup)")] = count
        
        return count
    }
}
