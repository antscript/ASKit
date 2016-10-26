//
//  MyTest.swift
//  ASKit
//
//  Created by AntScript on 26/10/2016.
//
//



public class MyTest {
    
    static public func test() -> String {
        #if TARGET_OS_OSX
        return "hello mac"
        #else
        return "hello ios"
        #endif
    }
    
    
    
}
