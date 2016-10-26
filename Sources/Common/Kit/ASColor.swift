//
//  ASColor.swift
//  ASKit
//
//  Created by AntScript on 26/10/2016.
//
//


#import <TargetConditionals.h>

#if TARGET_OS_OSX
    import <AppKit/AppKit.h>
    public class ASColor:NSColor {
        
    }
#else
    import <UIKit/UIKit.h>
    public class ASColor:UIColor {
        
    }
#endif
