//
//  ASColor.swift
//  ASKit
//
//  Created by AntScript on 26/10/2016.
//
//


#if os(OSX)
    import AppKit
    public class ASColor:NSColor {
        
    }
#else
    import UIKit
    public class ASColor:UIColor {
        
    }
#endif
