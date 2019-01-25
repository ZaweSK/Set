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
        game.beingPlayedCards += game.addCardsToGame(numberOfCardsToAdd: 12)
        cardsContainerView.addCardButtons(byAmount: 12)
        assignTargetAction()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dealMoreCardsGesture))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayCards()
        
    }
    
    private func assignTargetAction(){
        for button in cardsContainerView.buttons{
            button.addTarget(self, action: #selector(tapButtonGesture), for: .touchUpInside)
        }
    }
    
    private func displayCards(){
        if cardsContainerView.buttons.count > game.beingPlayedCards.count {
            cardsContainerView.removeCardButtons(byAmount: cardsContainerView.buttons.count - game.beingPlayedCards.count)
        }
        
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
            
            switch currentCard.number{
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
            
            
            
            if game.selectedCards.contains(currentCard)  {
                cardButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            } else {
                cardButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            
            if game.matchedTrio.contains(currentCard){
                cardButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            }else if game.missmatchedTrio.contains(currentCard){
                cardButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }
    
            ////// DOKONCI
            
        }
        
        
        
        handleDealMoreCardsButton()
    }
    
    private func handleDealMoreCardsButton(){
        dealMoreCardsButton.isEnabled = game.deck.count > 0
//        dealMoreCardsButton.setColor()
    }
    
    @IBOutlet weak var dealMoreCardsButton: UIButton!
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        guard game.deck.count > 0 else {return}
        game.beingPlayedCards += game.addCardsToGame(numberOfCardsToAdd: 3)
        cardsContainerView.addCardButtons(byAmount: 3)
        assignTargetAction()
        displayCards()
    }
    
    
    @objc func dealMoreCardsGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.state{
        case .ended:
            dealMoreCards(dealMoreCardsButton)
        default: break
        }
    }
    

    
    @IBAction func shuffleGesture(_ sender: UIRotationGestureRecognizer) {
        switch sender.state{
        case .ended:
            game.beingPlayedCards.shuffle()
            displayCards()
        default: break
        }
    }
    
    var selectedButtonsIndexes = [Int]()
    
    @objc func tapButtonGesture(_ sender: UIButton){
        guard let index = cardsContainerView.buttons.index(of: sender as! CardButton) else {return}
        game.selectCard(at:index)
        displayCards()
    }
    
    private func highlightMatchedCardButtons(){
        for buttonIndex in selectedButtonsIndexes{
            (cardsContainerView.buttons[buttonIndex]).backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
    }
    private func highlightMissmatchedCardButtons(){
        print("nezhoda")
        for buttonIndex in selectedButtonsIndexes{
            (cardsContainerView.buttons[buttonIndex]).backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    
    
    
    @IBOutlet weak var cardsContainerView: CardsContainerView!
    
}


extension UIButton {
    func setColor(){
        switch isEnabled{
        case true:  backgroundColor = #colorLiteral(red: 0.9416441942, green: 0.541214956, blue: 0.01731035626, alpha: 1)
        case false: backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.3501177226)
        }
    }
}
