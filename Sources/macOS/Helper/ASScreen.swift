//
//  ASScreen.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//


import Foundation
import Cocoa

public class ASScreen {
    
    
    public static func captureScreen() -> ASImage? {
        return captureScreen(screen: NSScreen.main()!)
    }
    static func captureScreen(screen: NSScreen) -> NSImage? {
        let screenID = (screen.deviceDescription["NSScreenNumber"] as! NSNumber).int32Value
        let cgImage = CGDisplayCreateImage(CGDirectDisplayID(screenID))
        let data = NSMutableData()
        let dest = CGImageDestinationCreateWithData(data, kUTTypePNG, 1, nil)
        CGImageDestinationAddImage(dest!, cgImage!, nil)
        CGImageDestinationFinalize(dest!)
        let image = NSImage(data: data as Data)
        return image
    }
    
    
    public static func captureScreen(screen: NSScreen, destination: String) -> NSURL{
        return captureScreen(screen: screen, destination: NSURL(string: destination)!)
    }
    public static func captureScreen(destination: String) -> NSURL{
        return captureScreen(screen: NSScreen.main()!, destination: NSURL(string: destination)!)
    }
    public static func captureScreen(screen: NSScreen, destination: NSURL) -> NSURL {
        let screenID = (screen.deviceDescription["NSScreenNumber"] as! NSNumber).int32Value
        let cgImage = CGDisplayCreateImage(CGDirectDisplayID(screenID))
        let dest = CGImageDestinationCreateWithURL(destination, kUTTypePNG, 1, nil)
        CGImageDestinationAddImage(dest!, cgImage!, nil)
        CGImageDestinationFinalize(dest!)
        return destination
    }
    
}

