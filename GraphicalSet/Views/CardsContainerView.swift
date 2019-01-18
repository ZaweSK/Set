//
//  CardsContainerView.swift
//  GraphicalSet
//
//  Created by Peter on 15/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class CardsContainerView: UIView {
    
    
    var buttons = [CardButton]()
    private(set) var grid = Grid(layout: Grid.Layout.aspectRatio(3/2))
    
    private var centeredRect: CGRect {
        get {
            return CGRect(x: bounds.size.width * 0.025,
                          y: bounds.size.height * 0.025,
                          width: bounds.size.width * 0.95,
                          height: bounds.size.height * 0.95)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        grid.frame = centeredRect
        
        for (i, button) in buttons.enumerated(){
            if let frame = grid[i]{
                button.frame = frame
                button.layer.cornerRadius = 10
                button.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                button.layer.borderWidth = 0.5
            }
        }
    }
    
    func addCardButtons(byAmount numberOfButtons: Int = 3) {
        let cardButtons = (0..<numberOfButtons).map { _ in CardButton() }
        for button in cardButtons {
            addSubview(button)
        }
        
        buttons += cardButtons
        grid.cellCount = buttons.count
        setNeedsLayout()
    }
    
    /// Removes all buttons from the container.
    func clearCardContainer() {
        buttons = []
        grid.cellCount = 0
        removeAllSubViews()
        setNeedsLayout()
    }
}

extension UIView{
    func removeAllSubViews(){
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
}
