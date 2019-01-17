import Foundation

struct SetGame {
    var deck: [Card] = {
        var deckSetUp = [Card]()
        for color in 1...3 {
            for shading in 1...3{
                for number in 1...3{
                    for symbol in 1...3{
                        deckSetUp.append(Card(color: Color(rawValue: color)!,
                                              shading: Shading(rawValue: shading)!,
                                              number: Number(rawValue: number)!,
                                              symbol: Symbol(rawValue: symbol)!))
                    }
                }
            }
        }
        return deckSetUp.shuffled()
    }()
    
    var alreadyMatchedCards = [Card]()
    var selectedCards = [Card]()
    
    var beingPlayedCards = [Card]()
     
    
    mutating func addCardsToGame(numberOfCardsToAdd: Int)->[Card]{
        var cardsToReturn = [Card]()
        for i in 0..<numberOfCardsToAdd{
            cardsToReturn += [deck.remove(at: i)]
        }
        return cardsToReturn
    }
    
    mutating func tryAndMatch()->Bool{
        let first:Card = selectedCards[0]
        let second:Card = selectedCards[1]
        let third = selectedCards[2]
        
        var colorFlag = false, symbolFlag = false, numberFlag = false, shadingFlag = false
        
        if (first.color == second.color && second.color == third.color && first.color == third.color )
            || (first.color != second.color && second.color != third.color && first.color != third.color){
            colorFlag = true
        }
        
        if (first.number == second.number && second.number == third.number && first.number == third.number )
            || (first.number != second.number && second.number != third.number && first.number != third.number){
            numberFlag = true
        }
        
        if (first.symbol == second.symbol && second.symbol == third.symbol && first.symbol == third.symbol )
            || (first.symbol != second.symbol && second.symbol != third.symbol && first.symbol != third.symbol){
            symbolFlag = true
        }
        
        if (first.shading == second.shading && second.shading == third.shading && first.shading == third.shading )
            || (first.shading != second.shading && second.shading != third.shading && first.shading != third.shading){
            shadingFlag = true
        }
        
        let result = colorFlag && symbolFlag && shadingFlag && numberFlag
        
        //        return true
        //        return false
        return result
        
    }
    
    mutating func moveMatchedCards(){
        for _ in selectedCards{
            let card = selectedCards.removeLast()
            alreadyMatchedCards += [card]
        }
    }
    
}

extension Array where Element: Equatable{
    mutating func remove(element: Element){
        if let index = self.index(of: element){
            self.remove(at: index)
        }
    }
}
