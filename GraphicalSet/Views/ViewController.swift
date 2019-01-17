//
//  ViewController.swift
//  GraphicalSet
//
//  Created by Peter on 15/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = SetGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.beingPlayedCards = game.addCardsToGame(numberOfCardsToAdd: 50)
        cardsContainerView.addCardButtons(byAmount: 50)
        
        print(cardsContainerView.buttons.count)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayCards()
        
    }
    
    private func displayCards(){
        print("displaying cards")
        for (index, cardButton) in cardsContainerView.buttons.enumerated(){
            let currentCard = game.beingPlayedCards[index]
            
            switch currentCard.color{
            case .option1:
                cardButton.cardColor = .green
            case .option2:
                cardButton.cardColor = .purple
            case .option3:
                cardButton.cardColor = .red
            }
            
            switch currentCard.color{
            case .option1:
                cardButton.numberOfSymbols = 1
            case .option2:
                cardButton.numberOfSymbols = 2
            case .option3:
                cardButton.numberOfSymbols = 3
            }
            
            switch currentCard.symbol{
            case .option1:
                cardButton.symbolShape = .oval
            case .option2:
                cardButton.symbolShape = .squiggle
            case .option3:
                cardButton.symbolShape = .diamond
            }
            
            switch currentCard.shading{
            case .option1:
                cardButton.shading = .outlined
            case .option2:
                cardButton.shading = .striped
            case .option3:
                cardButton.shading = .solid
            }
        }
    }
    
    
    
    
    
    @IBAction func selectCardButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var cardsContainerView: CardsContainerView!
    
}


