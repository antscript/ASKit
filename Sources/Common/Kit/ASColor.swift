//
//  ASColor.swift
//  ASKit
//
//  Created by AntScript on 26/10/2016.
//
//


#if os(OSX)
    import AppKit
    typealias ASColor = NSColor
#else
    import UIKit
    typealias ASColor = UIColor
#endif
