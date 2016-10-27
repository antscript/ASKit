//
//  RxUI.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation
import AppKit

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

public infix operator <->

public func <-> (slider:NSSlider, variable: Variable<Double>) -> Disposable {
    let bindToUIDisposeable = variable.asObservable()
        .bindTo(slider.rx.value)
    
    let bindToVariable = slider.rx.value
        .subscribe(onNext: { (value) in
            if variable.value != value {
                variable.value = value
            }
            
            }, onError: { (err) in
                
            }, onCompleted: {
                bindToUIDisposeable.dispose()
        }) {
            
    }
    
    return Disposables.create(bindToUIDisposeable, bindToVariable)
}


public func <-> (switchButton:NSButton, variable: Variable<Int>) -> Disposable {
    let bindToUIDisposeable = variable.asObservable()
        .bindTo(switchButton.rx.state)
    
    let bindToVariable = switchButton.rx.state
        .subscribe(onNext: { (value) in
            if variable.value != value {
                variable.value = value
            }
            
            }, onError: { (err) in
                
            }, onCompleted: {
                bindToUIDisposeable.dispose()
        }) {
            
    }
    
    return Disposables.create(bindToUIDisposeable, bindToVariable)
}
