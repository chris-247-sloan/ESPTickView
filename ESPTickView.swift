//
//  ESPTickView.swift
//  elitelive
//
//  Created by Chris Sloan on 31/10/2016.
//  Copyright © 2016 e-s-p.com. All rights reserved.
//

import UIKit

class ESPTickView: UIView {

    let π:CGFloat = CGFloat.pi

    let clearColor: UIColor = UIColor.clear

    let activeColor: UIColor = UIColor.green
    let greyedColor: UIColor = UIColor.gray
    let completeColor: UIColor = UIColor.white

    let circle = CAShapeLayer()

	var shouldAnimate: Bool = false
    //
    // MARK: - Initialisers
    //
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {

        if (shouldAnimate) {
            let center = CGPoint(x:self.bounds.width/2, y: self.bounds.height/2)
            let arcWidth: CGFloat = 1.0
            let radius: CGFloat = max(self.bounds.width, self.bounds.height) - arcWidth
            let startAngle: CGFloat = 7 * π / 4
            let endAngle: CGFloat = (7 * π / 4) - 0.0000001


            let circlePath = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
			clearColor.setStroke()
            circlePath.lineJoinStyle = CGLineJoin.round
            circlePath.lineCapStyle = CGLineCap.round
            circlePath.move(to: CGPoint(
                x:self.bounds.width * 0.15 ,
                y:self.bounds.height * 0.5))

            circlePath.addLine(to: CGPoint(
                x:self.bounds.width * 0.4,
                y:self.bounds.height * 0.75))

            circlePath.addLine(to: CGPoint(
                x:self.bounds.width * 0.8 ,
                y:self.bounds.height * 0.25))

            circlePath.stroke()

            circle.path = circlePath.cgPath
            circle.lineCap = kCALineJoinRound
            circle.lineCap = kCALineCapRound
            circle.strokeColor = activeColor.cgColor
            circle.fillColor = clearColor.cgColor
            circle.strokeEnd = 1.0
            circle.lineWidth = arcWidth * 2

            self.layer.addSublayer(circle)

            let drawCircleAnimation = CABasicAnimation(keyPath: "strokeEnd")
            drawCircleAnimation.repeatCount = 1.0

            // Animate from the full stroke being drawn to none of the stroke being drawn
            drawCircleAnimation.fromValue = 0.0
            drawCircleAnimation.toValue = 0.999

            //drawAnimation.beginTime = CACurrentMediaTime() + 2.3
            drawCircleAnimation.duration = 0.5
            
            drawCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            // Add the animation to the circle
            circle.add(drawCircleAnimation, forKey: "drawCircleAnimation")
        } else {

			circle.removeAllAnimations()
            circle.removeFromSuperlayer()
//
//            let center = CGPoint(x:self.bounds.width/2, y: self.bounds.height/2)
//            let arcWidth: CGFloat = 1.0
//            let radius: CGFloat = max(self.bounds.width, self.bounds.height) - arcWidth
//            let startAngle: CGFloat = 7 * π / 4
//            let endAngle: CGFloat = (7 * π / 4) - 0.0000001
//            let circlePath = UIBezierPath(arcCenter: center,
//                                          radius: radius/2 - arcWidth/2,
//                                          startAngle: startAngle,
//                                          endAngle: endAngle,
//                                          clockwise: true)
//            circlePath.lineWidth = arcWidth
//            clearColor.setStroke()
//            circlePath.stroke()
//
//            let tickPath = UIBezierPath()
//            tickPath.lineWidth = 4.0 * 2
//            tickPath.lineJoinStyle = CGLineJoin.round
//            tickPath.lineCapStyle = CGLineCap.round
//
//            tickPath.move(to: CGPoint(
//                x:bounds.width * 0.15 ,
//                y:bounds.height * 0.5))
//
//            tickPath.addLine(to: CGPoint(
//                x:bounds.width * 0.4,
//                y:bounds.height * 0.75))
//
//            tickPath.addLine(to: CGPoint(
//                x:bounds.width * 0.8 ,
//                y:bounds.height * 0.25))
//            clearColor.setStroke()
//            tickPath.stroke()
        }
    }

    func animate()
    {

		shouldAnimate = true
        setNeedsDisplay()

    }

    func hide()
    {
		shouldAnimate = false
        setNeedsDisplay()
    }
}



