import Algorithms
import Foundation

struct Day08: AdventDay {
    var data: String
    
    func part1() -> Any {
        let (steps, nodes) = processData(data)
        
        var stepCount = 0
        var currentNode = "AAA"
        var i = 0
        var found = false
        while !found {
            if i == steps.count  { i = 0 }
            
            currentNode = steps[i] == "L" ? (nodes[currentNode] ?? ("","")).0 : (nodes[currentNode] ?? ("","")).1
            stepCount += 1
            i += 1

            if currentNode == "ZZZ" {
                found = true
            }
        }
        
        return stepCount
    }

    func part2() -> Any {
        let (steps, nodes) = processData(data)
        var startingNodes: [String] = Array(nodes.filter({ $0.key.hasSuffix("A") }).keys)
        var endNodes: [Int] = []
        var stepCount = 0
        var found = false
        var i = 0

        while !found {
            if i == steps.count { i = 0 }
            
            for n in 0..<startingNodes.count {
                startingNodes[n] = steps[i] == "L" ? (nodes[startingNodes[n]] ?? ("","")).0 : (nodes[startingNodes[n]] ?? ("","")).1
                if startingNodes[n].hasSuffix("Z") {
                    endNodes.append(stepCount + 1)
                }
            }
            
            stepCount += 1
            i += 1

            if endNodes.count == startingNodes.count {
                found = true
            }
        }
        
        return lcm(endNodes)
    }
    
    func processData(_ data: String) -> ([Character], [String: (String, String)]) {
        let steps: [Character] = Array(data.split(separator: "\n\n").first ?? "")
        let nodes: [String: (String, String)] = (data.split(separator: "\n\n").last ?? "").split(separator: "\n").reduce(([String: (String, String)]())) { partialNodes, nodeData in
            var partialNodes = partialNodes
            let split = nodeData.split(separator: "=")
            let input = String(split.first ?? "")
            let target = (split.last ?? "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").split(separator: ",")
            
            partialNodes[input.trimmingCharacters(in: .whitespaces)] = (String(target.first ?? "").trimmingCharacters(in: .whitespaces), String(target.last ?? "").trimmingCharacters(in: .whitespaces))
            
            return partialNodes
        }
        
        return (steps, nodes)
    }
    
    func gcd(_ x: Int, _ y: Int) -> Int {
        var a = 0
        var b = max(x, y)
        var r = min(x, y)
        
        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }

    func lcm(a: Int, b: Int) -> Int {
        return (a / gcd(a, b)) * b
    }
    
    func lcm(_ vector : [Int]) -> Int {
        return vector.reduce(1, lcm)
    }
}
