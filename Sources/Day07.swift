import Algorithms
import Foundation

enum HandType: Int {
    case fiveOfAKind = 6
    case fourOfAKind = 5
    case fullHouse = 4
    case threeOfAKind = 3
    case twoPair = 2
    case onePair = 1
    case highCard = 0
}

struct Hand {
    let type: HandType
    let bid: Int
    let cards: [Int]
}

struct Day07: AdventDay {
    var data: String
    
    func part1() -> Any {
        let cardMap: [Character: Int] = [
            Character("2"): 2,
            Character("3"): 3,
            Character("4"): 4,
            Character("5"): 5,
            Character("6"): 6,
            Character("7"): 7,
            Character("8"): 8,
            Character("9"): 9,
            Character("T"): 10,
            Character("J"): 11,
            Character("Q"): 12,
            Character("K"): 13,
            Character("A"): 14
        ]
        
        var hands = data.split(separator: "\n").map({
            let d = $0.split(separator: " ")
            let cards: [Int] = Array(d[0]).map({
                return cardMap[$0, default: 0]
            })
            let handType = determineHandType(cards)
            let hand = Hand(type: handType, bid: Int(d[1]) ?? 0, cards: cards)
            return hand
        })
        
        // Sort hands by handType and card value
        hands = hands.sorted(by: {
            if $0.type.rawValue == $1.type.rawValue {
                return ($0.cards[0],$0.cards[1],$0.cards[2],$0.cards[3],$0.cards[4]) < ($1.cards[0],$1.cards[1],$1.cards[2],$1.cards[3],$1.cards[4])
            } else {
                return $0.type.rawValue < $1.type.rawValue
            }
        })

        let winnings = hands.enumerated().reduce(into: 0) { partialResult, hand in
            partialResult += (hand.1.bid * (hand.0 + 1))
        }
        
        return winnings
    }

    func part2() -> Any {
        let cardMap: [Character: Int] = [
            Character("J"): 1,
            Character("2"): 2,
            Character("3"): 3,
            Character("4"): 4,
            Character("5"): 5,
            Character("6"): 6,
            Character("7"): 7,
            Character("8"): 8,
            Character("9"): 9,
            Character("T"): 10,
            Character("Q"): 12,
            Character("K"): 13,
            Character("A"): 14
        ]
        
        var hands = data.split(separator: "\n").map({
            let d = $0.split(separator: " ")
            let cards: [Int] = Array(d[0]).map({
                return cardMap[$0, default: 0]
            })
            let handType = determineHandType(cards)
            let hand = Hand(type: handType, bid: Int(d[1]) ?? 0, cards: cards)
            return hand
        })
        
        // Sort hands by handType and card value
        hands = hands.sorted(by: {
            if $0.type.rawValue == $1.type.rawValue {
                return ($0.cards[0],$0.cards[1],$0.cards[2],$0.cards[3],$0.cards[4]) < ($1.cards[0],$1.cards[1],$1.cards[2],$1.cards[3],$1.cards[4])
            } else {
                return $0.type.rawValue < $1.type.rawValue
            }
        })
        
        let winnings = hands.enumerated().reduce(into: 0) { partialResult, hand in
            partialResult += (hand.1.bid * (hand.0 + 1))
        }
        
        return winnings
    }
    
    func determineHandType(_ cards: [Int]) -> HandType {
        var cardCount = [Int: Int]()
        
        for card in cards {
            cardCount[card, default: 0] += 1
        }
        
        // Replace Jokers with highest, favorouble card
        if cardCount[1] != nil {
            var bestReplacement = 14
            var bestReplacementCount = 0
            
            cardCount.forEach { k, v in
                if k != 1, v > bestReplacementCount {
                    bestReplacementCount = v
                    bestReplacement = k
                }
            }
            
            cardCount[bestReplacement, default: 0] += cardCount[1] ?? 0
            cardCount[1] = 0
        }
        
        // Determine hand type based on all cards
        var handType: HandType = .highCard
        if cardCount.contains(where: { $0.1 == 5 }) {
            handType = .fiveOfAKind
        } else if cardCount.contains(where: { $0.1 == 4 }) {
            handType = .fourOfAKind
        } else if cardCount.contains(where: { $0.1 == 3 }) {
            if cardCount.contains(where: { $0.1 == 2 }) {
                handType = .fullHouse
            } else {
                handType = .threeOfAKind
            }
        } else if cardCount.contains(where: { $0.1 == 2 }) {
            if cardCount.filter({ $0.1 == 2 }).count == 2 {
                handType = .twoPair
            } else {
                handType = .onePair
            }
        }
        
        return handType
    }
}
