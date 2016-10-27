//
//  SystemEventsViewModel.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Cocoa
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

public class SystemEventsViewModel {
    
    
    
    
    //    output
    public let sleepDid = PublishSubject<Void>()
    public let wakeDid = PublishSubject<Void>()
    public let screensaverDidStart = PublishSubject<Void>()
    public let screensaverDidStop = PublishSubject<Void>()
    public let lockDid = PublishSubject<Void>()
    public let unlockDid = PublishSubject<Void>()
    
    
    
    
    public init() {
        
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(action), name: NSNotification.Name("com.apple.screensaver.didstart"), object: nil)
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(action), name: NSNotification.Name("com.apple.screensaver.didstop"), object: nil)
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(action), name: NSNotification.Name("com.apple.screenIsLocked"), object: nil)
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(action), name: NSNotification.Name("com.apple.screenIsUnlocked"), object: nil)
        
        
        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(action), name: NSNotification.Name.NSWorkspaceWillSleep, object: nil)
        NSWorkspace.shared().notificationCenter.addObserver(self, selector: #selector(action), name: NSNotification.Name.NSWorkspaceDidWake, object: nil)
    }
    
    @objc func action(notification:Notification) {
        switch notification.name.rawValue {
        case Notification.Name.NSWorkspaceWillSleep.rawValue:
            sleepDid.onNext()
        case Notification.Name.NSWorkspaceDidWake.rawValue:
            wakeDid.onNext()
        case "com.apple.screensaver.didstart":
            screensaverDidStart.onNext()
        case "com.apple.screensaver.didstop":
            screensaverDidStop.onNext()
        case "com.apple.screenIsLocked":
            lockDid.onNext()
        case "com.apple.screenIsUnlocked":
            unlockDid.onNext()
        default:
            break
        }
    }
    
}
