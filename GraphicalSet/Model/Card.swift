import Foundation
struct Card: Equatable, Comparable{
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.color.rawValue < rhs.color.rawValue
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color &&
            lhs.shading == rhs.shading &&
            lhs.number == rhs.number &&
            lhs.symbol == rhs.symbol
        
    }
    
    let color: Color
    let shading: Shading
    let number: Number
    let symbol: Symbol
    
    init(color: Color, shading: Shading, number: Number, symbol: Symbol){
        self.color = color
        self.shading = shading
        self.number = number
        self.symbol = symbol
    }
}
enum Color: Int {
    case option1 = 1
    case option2
    case option3
}

enum Shading: Int {
    case option1 = 1
    case option2
    case option3
    
}

enum Number: Int {
    case option1 = 1
    case option2
    case option3
}

enum Symbol: Int {
    case option1 = 1
    case option2
    case option3
}
