//
//  ProgressBar.swift
//  Pokedex
//
//  Created by Mike Milord on 26/12/2017.
//  Copyright © 2017 First Republic. All rights reserved.
//

import UIKit

class MLayer {
    
    private var _centerPoint : CGPoint!
    private var _radius : CGFloat!
    private var _trackCGColour : CGColor!
    private var _lineWidth : CGFloat!
    
    
    var centerPoint: CGPoint {
        if _centerPoint == nil {
            _centerPoint = CGPoint(x: 0.0, y: 0.0)
        }
        return _centerPoint
    }
    
    var radius : CGFloat {
        if _radius == nil {
            _radius = 0.0
        }
        
        return _radius
    }
    
    var trackCGColour : CGColor {
        
        if _trackCGColour == nil {
            _trackCGColour = UIColor.red.cgColor
        }
        return _trackCGColour
    }
    
    var lineWidth : CGFloat {
        if _lineWidth == nil {
            _lineWidth = 0.0
        }
        return _lineWidth
    }
    
    init(centerPoint : CGPoint , radius: CGFloat , lineWidth : CGFloat, trackColour : UIColor) {
        
        _centerPoint = centerPoint
        _radius = radius
        _trackCGColour = trackColour.cgColor
        _lineWidth = lineWidth
        
        
    }
    
    
    func makeLayer () -> CAShapeLayer {
        
        let mLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: (3*CGFloat.pi) / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        mLayer.path = circularPath.cgPath
        mLayer.strokeColor = trackCGColour
        mLayer.fillColor = UIColor.clear.cgColor
        mLayer.lineWidth = lineWidth
        
        return mLayer
    }
    
}



