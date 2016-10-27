//
//  ASLayer.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//


import Foundation

#if os(OSX)
    import Cocoa
#else
    import UIKit
#endif

public class LayerHelper {
    
    
    public static func createGradientLayer(frame:NSRect,colors:[CGColor],startPoint:NSPoint,endPoint:NSPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        return gradientLayer
    }
    
    
    
}

