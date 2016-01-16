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
    // MARK: Inspectable properties
    
    @IBInspectable public var checkLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    @IBInspectable public var checkColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    
    @IBInspectable public var containerLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    @IBInspectable public var containerColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    
    @IBInspectable public var circular: Bool = false {
        didSet {
            layoutLayers()
        }
    }
    @IBInspectable public var containerFillsOnSelected: Bool = false {
        didSet {
            colorLayers()
        }
    }
    
    // MARK: Box and check properties
    let containerLayer = CAShapeLayer()
    let checkLayer = CAShapeLayer()
    
    var containerFrame: CGRect {
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
        
        let halfLineWidth = containerLineWidth / 2
        return CGRect(x: x + halfLineWidth, y: y + halfLineWidth, width: sideLength - containerLineWidth, height: sideLength - containerLineWidth)
    }
    
    var containerPath: UIBezierPath {
        if circular {
            return UIBezierPath(ovalInRect: containerFrame)
        } else {
            return UIBezierPath(rect: containerFrame)
        }
    }
    var checkPath: UIBezierPath {
        let containerFrame = self.containerFrame
        
        // Add an offset for circular checkbox
        let offset = circular ? CGFloat(1.0 / 8) * containerFrame.width : 0
        let inset = ((containerLineWidth + checkLineWidth) / 2) + offset
        var innerRect = CGRectInset(containerFrame, inset, inset)
        innerRect.origin = CGPoint(x: innerRect.origin.x, y: innerRect.origin.y + (offset / 4))
        
        // Create check path
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
        // Initial colors
        checkLayer.fillColor = UIColor.clearColor().CGColor
        
        // Color and layout layers
        colorLayers()
        layoutLayers()
        
        // Add layers
        layer.addSublayer(containerLayer)
        layer.addSublayer(checkLayer)
    }
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Also layout the layers when laying out subviews
        layoutLayers()
    }
    
    // MARK: Layout layers
    private func layoutLayers() {
        // Set frames, line widths and paths for layers
        containerLayer.frame = bounds
        containerLayer.lineWidth = containerLineWidth
        containerLayer.path = containerPath.CGPath
        
        checkLayer.frame = bounds
        checkLayer.lineWidth = checkLineWidth
        checkLayer.path = checkPath.CGPath
    }
    
    // MARK: Color layers
    private func colorLayers() {
        containerLayer.strokeColor = containerColor.CGColor
        
        // Set colors based on selection
        if selected {
            containerLayer.fillColor = containerFillsOnSelected ? containerColor.CGColor : UIColor.clearColor().CGColor
            checkLayer.strokeColor = checkColor.CGColor
        } else {
            containerLayer.fillColor = UIColor.clearColor().CGColor
            checkLayer.strokeColor = UIColor.clearColor().CGColor
        }
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
