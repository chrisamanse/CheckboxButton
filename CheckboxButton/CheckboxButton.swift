//
//  CheckboxButton.swift
//  CheckboxButton
//
//  Created by Joe Amanse on 30/11/2015.
//  Copyright © 2015 Joe Christopher Paul Amanse. All rights reserved.
//

import UIKit

@IBDesignable
public class CheckboxButton: UIButton {
    // MARK: Box and check properties
    let boxLayer = CAShapeLayer()
    let checkLayer = CAShapeLayer()
    
    var boxFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let x: CGFloat
        let y: CGFloat
        
        let sideLength: CGFloat
        if width > height {
            sideLength = height
            x = (width - sideLength) / 2
            y = 0
        } else {
            sideLength = width
            x = 0
            y = (height - sideLength) / 2
        }
        
        let halfLineWidth = boxLineWidth / 2
        return CGRect(x: x + halfLineWidth, y: y + halfLineWidth, width: sideLength - boxLineWidth, height: sideLength - boxLineWidth)
    }
    
    var boxPath: UIBezierPath {
        return UIBezierPath(rect: boxFrame)
    }
    var checkPath: UIBezierPath {
        let inset = (boxLineWidth + checkLineWidth) / 2
        let innerRect = CGRectInset(boxFrame, inset, inset)
        let path = UIBezierPath()
        
        let unit = innerRect.width / 8
        let origin = innerRect.origin
        let x = origin.x
        let y = origin.y
        
        path.moveToPoint(CGPoint(x: x + unit, y: y + unit * 5))
        path.addLineToPoint(CGPoint(x: x + unit * 3, y: y + unit * 7))
        path.addLineToPoint(CGPoint(x: x + unit * 7, y: y + unit))
        
        return path
    }
    
    // MARK: Inspectable properties
    @IBInspectable public var boxLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    @IBInspectable public var checkLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    @IBInspectable public var boxLineColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    @IBInspectable public var checkLineColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    
    // MARK: Initialization
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        customInitialization()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    
    func customInitialization() {
        boxLayer.fillColor = UIColor.clearColor().CGColor
        checkLayer.fillColor = UIColor.clearColor().CGColor
        
        colorLayers()
        layoutLayers()
        
        layer.addSublayer(boxLayer)
        layer.addSublayer(checkLayer)
    }
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutLayers()
    }
    
    // MARK: Layout layers
    private func layoutLayers() {
        boxLayer.frame = bounds
        boxLayer.lineWidth = boxLineWidth
        boxLayer.path = boxPath.CGPath
        
        checkLayer.frame = bounds
        checkLayer.lineWidth = checkLineWidth
        checkLayer.path = checkPath.CGPath
    }
    
    // MARK: Color layers
    private func colorLayers() {
        boxLayer.strokeColor = boxLineColor.CGColor
        checkLayer.strokeColor = selected ? checkLineColor.CGColor : UIColor.clearColor().CGColor
    }
    
    // MARK: Selection
    public override var selected: Bool {
        didSet {
            colorLayers()
        }
    }
    
    // MARK: Interface builder
    public override func prepareForInterfaceBuilder() {
        customInitialization()
    }
}
