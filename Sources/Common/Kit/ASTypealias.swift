//
//  ASColor.swift
//  ASKit
//
//  Created by AntScript on 26/10/2016.
//
//


#if os(OSX)
    import AppKit
    public typealias ASColor = NSColor
#else
    import UIKit
    public typealias ASColor = UIColor
#endif


#if os(OSX)
    import AppKit
    public typealias ASImage = NSImage
#else
    import UIKit
    public typealias ASImage = UIImage
#endif
