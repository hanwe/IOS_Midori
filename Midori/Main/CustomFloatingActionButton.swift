//
//  CustomFloatingActionButton.swift
//  Midori
//
//  Created by hanwe on 2016/6/7.
//  Copyright © 2016年 hanwe. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton

class CustomFloatingActionButton: LiquidFloatingActionButton
{

    override internal func createPlusLayer(frame: CGRect) -> CAShapeLayer
    {
        
        let plusLayer = CAShapeLayer()
        plusLayer.lineCap = kCALineCapRound
        plusLayer.strokeColor = UIColor.whiteColor().CGColor
        plusLayer.lineWidth = 3.0
        
        let w = frame.width
        let h = frame.height
        
        let points = [
            (CGPoint(x: w * 0.25, y: h * 0.35), CGPoint(x: w * 0.75, y: h * 0.35)),
            (CGPoint(x: w * 0.25, y: h * 0.5), CGPoint(x: w * 0.75, y: h * 0.5)),
            (CGPoint(x: w * 0.25, y: h * 0.65), CGPoint(x: w * 0.75, y: h * 0.65))
        ]
        
        let path = UIBezierPath()
        for (start, end) in points {
            path.moveToPoint(start)
            path.addLineToPoint(end)
        }
        
        plusLayer.path = path.CGPath
        
        return plusLayer
    }

}
