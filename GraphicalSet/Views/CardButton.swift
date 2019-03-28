//
//  CardButton.swift
//  GraphicalSet
//
//  Created by Peter on 16/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    override var description: String {
        return ("Symbol: \(self.symbolShape), Number: \(self.numberOfSymbols), Color : \(self.cardColor), SHading : \(self.shading)")
    }
    
    enum SymbolShape{
        case squiggle
        case diamond
        case oval
    }
    enum CardColor{
        case red
        case green
        case purple
        
        func get()->UIColor{
            switch self{
            case .red: return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            case .green: return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            case .purple: return #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    enum Shading{
        case solid
        case striped
        case outlined
    }
    
    var numberOfSymbols = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var symbolShape: SymbolShape?  {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    var cardColor: CardColor?  {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var shading: Shading?  {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var colorOfCard: UIColor? {
        get{
           return backgroundColor
        }
        set{
            backgroundColor = newValue
            setNeedsDisplay()
        }
    }
    
   
    
    private var shapeHorizontalMargin: CGFloat {
        return drawableRect.width * 0.05
    }
    
    private var shapeVerticalMargin: CGFloat {
        return drawableRect.height * 0.05 + drawableRect.origin.y
    }
    
    private var shapeWidth: CGFloat {
        return (drawableRect.width - (2 * shapeHorizontalMargin)) / 3
    }
    
    private var shapeHeight: CGFloat {
        return drawableRect.size.height * 0.9
    }
    
    private var drawableCenter: CGPoint {
        return CGPoint(x: drawableRect.midX , y: drawableRect.midY)
    }
    
    
    private var drawableRect: CGRect{
        let drawableWidth = frame.size.width * 0.8
        let drawableHeight = frame.size.height * 0.9
        
        return CGRect(x: frame.size.width * 0.1,
                      y: frame.size.height * 0.05,
                      width: drawableWidth,
                      height: drawableHeight)
    }
    
    
    var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        guard let symbolShape = self.symbolShape else {return}
        guard let shading = self.shading else {return}
        guard let cardColor = self.cardColor?.get() else {return}
        
        switch symbolShape{
        case .squiggle:
            drawSquiggles(byAmount: numberOfSymbols)
        case .diamond:
            drawDiamonds(byAmount: numberOfSymbols)
        case .oval:
            drawOvals(byAmount: numberOfSymbols)
        }
        
        path!.lineCapStyle = .round
        
        switch shading{
        case .solid:
            cardColor.setFill()
            path!.fill()
        case .outlined:
            cardColor.setStroke()
            path!.lineWidth = 0.01 * frame.size.width
            path!.stroke()
            
        case .striped:
            path!.lineWidth = 0.01 * frame.size.width
            cardColor.setStroke()
            path!.stroke()
            path!.addClip()
            
            var currentX: CGFloat = 0
            
            let stripedPath = UIBezierPath()
            stripedPath.lineWidth = 0.005 * frame.size.width
            
            while currentX < frame.size.width {
                stripedPath.move(to: CGPoint(x: currentX, y: 0))
                stripedPath.addLine(to: CGPoint(x: currentX, y: frame.size.height))
                currentX += 0.03 * frame.size.width
            }
            
            cardColor.setStroke()
            stripedPath.stroke()
            
            break
        }
        
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: bounds.midX, y: bounds.origin.y))
        //        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
        //        path.lineWidth = 2.0
        //        path.stroke()
    }
    
    
    private func drawSquiggles(byAmount amount: Int){
        let path = UIBezierPath()
        let allSquigglesWidth = CGFloat(numberOfSymbols) * shapeWidth + CGFloat(numberOfSymbols - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allSquigglesWidth) / 2
        
        for i in 0..<numberOfSymbols {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            let currentShapeY = shapeVerticalMargin
            let curveXOffset = shapeWidth * 0.35
            
            path.move(to: CGPoint(x: currentShapeX, y: currentShapeY))
            
            path.addCurve(to: CGPoint(x: currentShapeX, y: currentShapeY + shapeHeight),
                          controlPoint1: CGPoint(x: currentShapeX + curveXOffset, y: currentShapeY + shapeHeight / 3),
                          controlPoint2: CGPoint(x: currentShapeX - curveXOffset, y: currentShapeY + (shapeHeight / 3) * 2))
            
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth, y: currentShapeY + shapeHeight))
            
            path.addCurve(to: CGPoint(x: currentShapeX + shapeWidth, y: currentShapeY),
                          controlPoint1: CGPoint(x: currentShapeX + shapeWidth - curveXOffset, y: currentShapeY + (shapeHeight / 3) * 2),
                          controlPoint2: CGPoint(x: currentShapeX + shapeWidth + curveXOffset, y: currentShapeY + shapeHeight / 3))
            
            path.addLine(to: CGPoint(x: currentShapeX, y: currentShapeY))
        }
        self.path = path
    }
    
    
    private func drawDiamonds(byAmount amount: Int){
        let allDiamondsWidth = CGFloat(numberOfSymbols) * shapeWidth + CGFloat(numberOfSymbols - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allDiamondsWidth) / 2
        let path = UIBezierPath()
        
        for i in 0..<numberOfSymbols {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            path.move(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeVerticalMargin))
            path.addLine(to: CGPoint(x: currentShapeX , y: drawableCenter.y))
            path.addLine(to: CGPoint(x: currentShapeX + shapeWidth / 2, y: shapeHeight + shapeVerticalMargin))
            path.addLine(to: CGPoint(x:currentShapeX + shapeWidth, y: drawableCenter.y))
            path.close()
        }
        self.path = path
    }

    private func drawOvals(byAmount amount: Int){
        let allOvalsWidth = CGFloat(numberOfSymbols) * shapeWidth + CGFloat(numberOfSymbols - 1) * shapeHorizontalMargin
        let beginX = (frame.size.width - allOvalsWidth) / 2
        path = UIBezierPath()
        
        for i in 0..<numberOfSymbols {
            let currentShapeX = beginX + (shapeWidth * CGFloat(i)) + (CGFloat(i) * shapeHorizontalMargin)
            path!.append(UIBezierPath(roundedRect: CGRect(x: currentShapeX,
                                                          y: shapeVerticalMargin,
                                                          width: shapeWidth,
                                                          height: shapeHeight),
                                      cornerRadius: shapeWidth))
            
        }
    }

}
