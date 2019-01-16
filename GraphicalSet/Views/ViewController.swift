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
        
        
        
       
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
   
    
    @IBAction func selectCardButton(_ sender: UIButton) {
       
    }
    
    @IBOutlet weak var cardsContainerView: UIView!
    
}


