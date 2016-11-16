//
//  App.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation


public struct AppInfo {
    static public var Version:String?
    static public var Build:String?
    static public var Name:String?
    static public var Copyright:String?
    static public var Email:String?
    static public var Logo:ASImage?
    static public var RateURL:String?
    static public var AppStoreURL:String?
    
    public static func setup(name:String?, email:String?, logo:ASImage?, copyright:String?, appStoreURL:String?, rateURL:String?, version:String? , build:String?) {
        AppInfo.Name = name == nil ? (Bundle.main.object(forInfoDictionaryKey: "CFBundleName")! as! String) : name!
        AppInfo.Email = email == nil ? "" : email!
        AppInfo.Logo = logo
        AppInfo.Copyright = copyright == nil ? "" : copyright!
        AppInfo.AppStoreURL = appStoreURL == nil ? "" : appStoreURL!
        AppInfo.RateURL = rateURL == nil ? "" : rateURL!
        AppInfo.Version = version == nil ? (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")! as! String) : version!
        AppInfo.Build = build == nil ? Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")! as! String : build!
    }
}
