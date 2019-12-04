//
//  JoystickDebugView.swift
//  RetroRampage
//
//  Created by Ben Scheirman on 12/4/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

import UIKit

public class JoystickDebugView : UIView {

    func update(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            isHidden = false
            let location = pan.location(in: self)
            centerPoint = CGPoint(x: location.x - radius, y: location.y - radius)
            thumbPoint = location

        case .changed:
            thumbPoint = pan.location(in: self)
        default:
            isHidden = true
        }
    }

    var radius: CGFloat = 10 {
        didSet { setNeedsDisplay() }
    }
    var centerPoint: CGPoint = .zero {
        didSet { setNeedsDisplay() }
    }
    var thumbPoint: CGPoint = .zero {
        didSet { setNeedsDisplay() }
    }
    var color: UIColor = .red {
        didSet { setNeedsDisplay() }
    }
    var strokeWidth: CGFloat = 4 {
        didSet { setNeedsDisplay() }
    }
    var centerSize: CGFloat = 12 {
        didSet { setNeedsDisplay() }
    }

    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        color.setFill()
        color.setStroke()

        context.move(to: centerPoint)
        context.addEllipse(in: CGRect(origin: thumbPoint, size: CGSize(width: centerSize, height: centerSize)))
        context.fillPath()

        context.addEllipse(in: CGRect(origin: centerPoint, size: CGSize(width: radius * 2, height: radius * 2)))
        context.setLineWidth(strokeWidth)
        context.strokePath()
    }
}
