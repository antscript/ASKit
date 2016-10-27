//
//  ASLinkButton.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation


public class ASLinkButton: NSButton {
    public init(_ title:String,color:NSColor = ASColor.blue.withAlphaComponent(0.6)) {
        super.init()
        
        isBordered = false
        focusRingType = .none
        attributedTitle = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: color])
    }
}
