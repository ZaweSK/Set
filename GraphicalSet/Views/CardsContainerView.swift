//
//  CardsContainerView.swift
//  GraphicalSet
//
//  Created by Peter on 15/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class CardsContainerView: UIView {
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        
        
      let myView = CardButton()
//      myView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
      addSubview(myView)
        myView.bounds.size = CGSize(width: 100, height: 100)
//        myView.frame = CGRect(origin: super.bounds.origin, size: CGSize(width: 150, height: 150))
//        myView.frame = CGRect(x: 10, y: 10, width: 150, height: 150)
        myView.frame.origin = CGPoint(x: super.bounds.maxX - myView.bounds.width - 10 , y: 50)

      
    
        
      
        
        
//        
    }

}
