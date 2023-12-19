import Algorithms
import Foundation

struct Day13: AdventDay {
    var data: String
    
    func part1() -> Any {
        let fields: [[Substring]] = data.split(separator: "\n\n").map({ $0.split(separator: "\n") })
        var resultCount = 0
        
        fields.forEach { field in
            let fieldFlipped = flipField(field)
            resultCount += checkField(field.map({ String($0) })) * 100
            resultCount += checkField(fieldFlipped)
        }
        
        return resultCount
    }
    
    func part2() -> Any {
        let fields: [[Substring]] = data.split(separator: "\n\n").map({ $0.split(separator: "\n") })
        var resultCount = 0
        
        fields.forEach { field in
            let fieldFlipped = flipField(field)
            if checkFieldWithSmudgeCheck(field.map({ String($0) })) != 0 {
                resultCount += checkFieldWithSmudgeCheck(field.map({ String($0) })) * 100
            } else {
                resultCount += checkFieldWithSmudgeCheck(fieldFlipped)
            }
        }
        
        return resultCount
    }
    
    func checkField(_ field: [String], _ lineNumber: Int? = nil) -> Int {
        var previousLine: String = ""
        var found = false
        
        for lineCount in 0..<field.count {
            if field[lineCount] == previousLine, !found {
                // For fixed fields check at specific split, to prevent matches at wrong mirror split
                if lineNumber != nil, lineCount != lineNumber {
                    found = false
                } else {
                    found = true
                }
                
                var count = 2
                for i in lineCount+1..<field.count {
                    if lineCount - count >= 0, field[i] != field[lineCount - count] {
                        found = false
                        break
                    }
                    
                    count += 1
                }
            }
            
            if found {
                return lineCount
            } else {
                previousLine = String(field[lineCount])
            }
        }
        
        return 0
    }
    
    func checkFieldWithSmudgeCheck(_ field: [String]) -> Int {
        var previousLine: String = ""
        
        for lineCount in 0..<field.count {
            var found = false
            var withDifference = false
            
            if field[lineCount] == previousLine, !found {
                found = true
                
                var count = 2
                for i in lineCount+1..<field.count {
                    if lineCount - count >= 0, field[i] != field[lineCount - count], !withDifference {
                        let differences = getDifferenceIndex(field[i], field[lineCount - count])
                        if differences.count == 1 {
                            var currentLineSplit = Array(field[i])
                            var fixedField = field
                            
                            currentLineSplit[differences[0]] = currentLineSplit[differences[0]] == "#" ? "." : "#"
                            fixedField[i] = String(currentLineSplit)
                            
                            if checkField(fixedField) != 0 {
                                withDifference = true
                            } else {
                                found = false
                                break
                            }
                        } else {
                            found = false
                        }
                    } else if lineCount - count >= 0, field[i] != field[lineCount - count] {
                        found = false
                        break
                    }
                    
                    count += 1
                }
            } else {
                let differences = getDifferenceIndex(field[lineCount], previousLine)
                if differences.count == 1 {
                    var fixedField = field
                    var currentLineSplit = Array(field[lineCount])
                    
                    currentLineSplit[differences[0]] = currentLineSplit[differences[0]] == "#" ? "." : "#"
                    fixedField[lineCount] = String(currentLineSplit)
                    
                    if checkField(fixedField, lineCount) != 0 {
                        found = true
                        withDifference = true
                    }
                }
            }
            
            if found, withDifference {
                return lineCount
            } else {
                previousLine = String(field[lineCount])
            }
        }
        
        return 0
    }
    
    func flipField(_ field: [Substring]) -> [String] {
        var fieldFlipped: [String] = []
        field.forEach { row in
            Array(String(row)).enumerated().forEach { char in
                if fieldFlipped.count <= char.offset {
                    fieldFlipped.append("")
                }
                fieldFlipped[char.offset].append(char.element)
            }
        }
        
        return fieldFlipped
    }
    
    func getDifferenceIndex(_ currentLine: String, _ previousLine: String) -> [Int] {
        let currentLineSplit = Array(currentLine)
        let previousLineSplit = Array(previousLine)
        return zip(previousLineSplit, currentLineSplit).enumerated().filter() {
            $1.0 != $1.1
        }.map{Int($0.0)}
    }
}
