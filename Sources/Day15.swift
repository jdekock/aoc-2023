import Algorithms
import Foundation

struct Lens {
    let label: String
    let focalLength: Int
}

struct Day15: AdventDay {
    var data: String

    func part1() -> Any {
        let steps = data.replacingOccurrences(of: "\n", with: "").split(separator: ",").map({ Array($0) })
        var values: [Int] = []
        
        steps.forEach { step in
            let stepValue = getAsciiValue(step)
            values.append(stepValue)
        }
        
        return values.reduce(0, +)
    }

    func part2() -> Any {
        let steps = data.replacingOccurrences(of: "\n", with: "").split(separator: ",").map({ Array($0) })
        var boxMap: [Int: [Lens]] = [:]
        
        steps.forEach { step in
            let add: Bool = step.contains("=") // Check if the step adds or removes a value
            var step = step
            
            // Remove unused characters
            step.removeAll(where: { $0 == "=" })
            step.removeAll(where: { $0 == "-" })
            
            let stepNum = step.compactMap({ if $0.isNumber { return $0 } else { return nil }})
            let stepChars = step.compactMap({ if !$0.isNumber { return $0 } else { return nil }})
            
            let boxNumber = getAsciiValue(stepChars)
            let lens = Lens(label: String(stepChars), focalLength: Int(String(stepNum)) ?? 0)
            
            if add {
                if let existingIndex = boxMap[boxNumber, default: []].firstIndex(where: { $0.label == lens.label }) {
                    boxMap[boxNumber, default: []][existingIndex] = lens
                } else {
                    boxMap[boxNumber, default: []].append(lens)
                }
            } else {
                if let existingIndex = boxMap[boxNumber, default: []].firstIndex(where: { $0.label == lens.label }) {
                    boxMap[boxNumber, default: []].remove(at: existingIndex)
                }
            }
        }
        
        var focusingPowers: [Int] = []
        boxMap.forEach { box in
            for i in 0..<box.value.count {
                focusingPowers.append((box.key + 1) * (i + 1) * box.value[i].focalLength)
            }
        }
        
        return focusingPowers.reduce(0, +)
    }
    
    func getAsciiValue(_ step: [Character]) -> Int {
        var stepValue = 0
        
        for character in step {
            stepValue += Int(character.asciiValue ?? 0)
            stepValue = stepValue * 17
            stepValue = stepValue - (256 * Int(floor(Double(stepValue / 256))))
        }
        
        return stepValue
    }
}
