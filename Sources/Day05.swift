import Algorithms
import Foundation

struct Day05: AdventDay {
    var data: String
    
    func part1() -> Any {
        let almanac = data.split(separator: "\n\n")
        let seeds = almanac[0].replacingOccurrences(of: "seeds: ", with: "").split(separator: " ").map({ Int($0) ?? 0 })
        var seedSteps: [[[Int]]] = []

        for i in 1..<almanac.count {
            seedSteps.append(almanac[i].split(separator: "\n").dropFirst().map({ $0.split(separator: " ").map({ Int($0) ?? 0 }) }))
        }
        
        var lowestLocation = -1
        for s in seeds {
            var currentValue = s
            
            seedSteps.forEach { step in
                for range in step {
                    if currentValue >= range[1] && currentValue < (range[1] + range[2]) {
                        currentValue = (currentValue - range[1]) + range[0]
                        break
                    }
                }
            }
            
            if lowestLocation == -1 {
                lowestLocation = currentValue
            } else {
                lowestLocation = min(lowestLocation, currentValue)
            }
        }
        
        return lowestLocation
    }

    func part2() -> Any {
        let almanac = data.split(separator: "\n\n")
        let seeds = almanac[0].replacingOccurrences(of: "seeds: ", with: "").split(separator: " ").map({ Int($0) ?? 0 })
        var seedSteps: [[[Int]]] = []

        for i in 1..<almanac.count {
            seedSteps.append(almanac[i].split(separator: "\n").dropFirst().map({ $0.split(separator: " ").map({ Int($0) ?? 0 }) }))
        }
        
        var lowestLocation = -1
        for i in stride(from: 0, to: seeds.count, by: 2) {
            for s in seeds[i]..<(seeds[i]+seeds[i+1]) {
                var currentValue = s
                
                seedSteps.forEach { step in
                    for range in step {
                        if currentValue >= range[1] && currentValue < (range[1] + range[2]) {
                            currentValue = (currentValue - range[1]) + range[0]
                            break
                        }
                    }
                }
                
                if lowestLocation == -1 {
                    lowestLocation = currentValue
                } else {
                    lowestLocation = min(lowestLocation, currentValue)
                }
            }
        }
        
        return lowestLocation
    }
}
