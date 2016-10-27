//
//  ASLabel.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation

public class ASLabel: NSTextField {
    public init(_ title:String,fontSize:Int,color:NSColor = NSColor.white, aligment:NSTextAlignment = .left) {
        super.init()
        
        font = NSFont.systemFont(ofSize: CGFloat(fontSize), weight: 0)
        usesSingleLineMode = true
        textColor = color
        backgroundColor = NSColor.clear
        drawsBackground = false
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor
        stringValue = title
        isEditable = false
        isBezeled = false
        alignment = aligment
    }
}
