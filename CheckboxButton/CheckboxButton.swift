//
//  CheckboxButton.swift
//  CheckboxButton
//
//  Created by Joe Amanse on 30/11/2015.
//  Copyright © 2015 Joe Christopher Paul Amanse. All rights reserved.
//

import UIKit

@IBDesignable
public class CheckboxButton: UIControl {
    // MARK: Public properties
    
    /// Line width for the check mark. Default value is 2.
    @IBInspectable public var checkLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    
    /// Color for the check mark. Default color is `UIColor.blackColor()`.
    @IBInspectable public var checkColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    
    /// Line width for the bounding container of the check mark.
    /// Default value is 2.
    @IBInspectable public var containerLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    
    /// Color for the bounding container of the check mark.
    /// Default color is `UIColor.blackColor()`.
    @IBInspectable public var containerColor: UIColor = UIColor.blackColor() {
        didSet {
            colorLayers()
        }
    }
    
    /// If set to `true`, the bounding container of the check mark will be a circle rather than a box.
    /// Default value is false
    @IBInspectable public var circular: Bool = false {
        didSet {
            layoutLayers()
        }
    }
    
    /// If set to `true`, the container gets a fill color similar to the `containerColor` property.
    /// Default value is `false`.
    @IBInspectable public var containerFillsOnToggleOn: Bool = false {
        didSet {
            colorLayers()
        }
    }
    
    /// A Boolean value that determines the off/on state of the checkbox. If `true`, the checkbox is checked.
    @IBInspectable public var on: Bool = false {
        didSet {
            colorLayers()
        }
    }
    
    // MARK: Internal and private properties
    
    internal let containerLayer = CAShapeLayer()
    internal let checkLayer = CAShapeLayer()
    
    internal var containerFrame: CGRect {
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
    
    internal var containerPath: UIBezierPath {
        if circular {
            return UIBezierPath(ovalInRect: containerFrame)
        } else {
            return UIBezierPath(rect: containerFrame)
        }
    }
    internal var checkPath: UIBezierPath {
        let containerFrame = self.containerFrame
        
        // Add an offset for circular checkbox
        let inset = containerLineWidth / 2
        let innerRect = CGRectInset(containerFrame, inset, inset)
        
        // Create check path
        let path = UIBezierPath()
        
        let unit = innerRect.width / 33
        let origin = innerRect.origin
        let x = origin.x
        let y = origin.y
        
        path.moveToPoint(CGPoint(x: x + (7 * unit), y: y + (18 * unit)))
        path.addLineToPoint(CGPoint(x: x + (14 * unit), y: y + (25 * unit)))
        path.addLineToPoint(CGPoint(x: x + (27 * unit), y: y + (10 * unit)))
        
        return path
    }
    
    static internal let validBoundsOffset: CGFloat = 80
    
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
    
    /**
     Initializes a new `CheckboxButton` with a set state.
     
     - Parameters:
     - frame: Frame of the receiver
     - on: On state of the receiver
     */
    convenience init(frame: CGRect, on: Bool) {
        self.init(frame: frame)
        self.on = on
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
        
        // Set colors based on 'on' property
        if on {
            containerLayer.fillColor = containerFillsOnToggleOn ? containerColor.CGColor : UIColor.clearColor().CGColor
            checkLayer.strokeColor = checkColor.CGColor
        } else {
            containerLayer.fillColor = UIColor.clearColor().CGColor
            checkLayer.strokeColor = UIColor.clearColor().CGColor
        }
    }
    
    // MARK: Touch tracking
    
    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        return true
    }
    
    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        return true
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        guard let touchLocationInView = touch?.locationInView(self) else {
            return
        }
        
        let offset = self.dynamicType.validBoundsOffset
        let validBounds = CGRect(x: bounds.origin.x - offset, y: bounds.origin.y - offset, width: bounds.width + (2 * offset), height: bounds.height + (2 * offset))
        
        if validBounds.contains(touchLocationInView) {
            on = !on
            sendActionsForControlEvents([UIControlEvents.ValueChanged])
        }
    }
    
    // MARK: Interface builder
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        customInitialization()
    }
}
