import Algorithms
import Foundation

struct Day01: AdventDay {
    var data: String
    
    let numbers: [String: String] = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    ]

    func part1() -> Any {
        let result = data
            .split(separator: "\n")
            .map({
                let result = String($0)
                let nums = Array(result).filter{ $0.isNumber }
                return Int(String("\(nums.first!)\(nums.last!)")) ?? 0
            }).reduce(0, +)
        
        return result
    }

    func part2() -> Any {
        let result = data
            .split(separator: "\n")
            .map({
                var result = String($0)
                let resultBackwards = String(Array($0).reversed())
                let regex = try! NSRegularExpression(pattern: "(one|two|three|four|five|six|seven|eight|nine)")
                let regexBackwards = try! NSRegularExpression(pattern: "(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno)")
                
                let firstResult = regex.firstMatch(in: result, range: NSRange(result.startIndex..., in: result))
                let lastResult = regexBackwards.firstMatch(in: resultBackwards, range: NSRange(resultBackwards.startIndex..., in: resultBackwards))
                  
                if let first = firstResult {
                    var lastNum: String?
                    var lastIndex: Int?
                    let firstNum = String(result[Range(first.range, in: result)!])
                    let firstIndex = first.range.lowerBound
                      
                    if let last = lastResult {
                        lastNum = String(Array(resultBackwards[Range(last.range, in: resultBackwards)!]).reversed())
                        lastIndex = (result.count - (last.range.lowerBound)) + 1
                    }
                      
                    let index = result.index(result.startIndex, offsetBy: firstIndex)
                    result.insert(contentsOf: numbers[firstNum, default: ""], at: index)
                      
                    if let lastNum = lastNum, let lastIndex = lastIndex {
                        let endIndex = result.index(result.startIndex, offsetBy: lastIndex)
                        result.insert(contentsOf: numbers[lastNum, default: ""], at: endIndex)
                    }
                }
                  
                let nums = Array(result).filter{ $0.isNumber }
                return Int(String("\(nums.first!)\(nums.last!)")) ?? 0
            }).reduce(0, +)
        
        return result
    }
}
