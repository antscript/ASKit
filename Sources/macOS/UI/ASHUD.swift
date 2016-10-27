//
//  ASHUD.swift
//  UPer
//
//  Created by AntScript on 5/18/16.
//  Copyright © 2016 AApp.Space. All rights reserved.
//

import Foundation
import Cocoa
import Cartography
import RxSwift

public class ASHUD {
    
    public static let shared =  ASHUD()
    
    private var window: NSWindow
    private var hudTextField: NSTextField?
    private var closeButton:NSButton?
    
    private var delayTask:ASTimerUtils.Task?
    
    private var disposeBag:DisposeBag?
    
    private init() {
        window = NSWindow(contentRect: NSRect.zero, styleMask: [], backing: .buffered, defer: false)
        window.level = Int(CGWindowLevelForKey(.floatingWindow))
        window.level = Int(CGWindowLevelForKey(.maximumWindow))
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        
        window.contentView?.layerContentsRedrawPolicy = .onSetNeedsDisplay
        window.contentView?.wantsLayer = true
    }
    
    private func setupUI(msg: String,
                 size: ASHUDSize = .medium,
                 style: ASHUDStyle = .dark,
                 bordered: Bool = false,
                 colors:[CGColor]? = nil,
                 titleColor:NSColor? = nil
        ) {
        
        
        let hudTextField = NSTextField()
        hudTextField.stringValue = msg
        hudTextField.preferredMaxLayoutWidth = (NSScreen.main()?.frame.width)! - 50
        hudTextField.isBordered = false
        hudTextField.isEditable = false
        hudTextField.drawsBackground = false
        hudTextField.alignment = .left
        hudTextField.usesSingleLineMode = true
        hudTextField.cell?.wraps = false
        hudTextField.sizeToFit()
        window.contentView!.addSubview(hudTextField)
        self.hudTextField = hudTextField
        
        disposeBag = DisposeBag()
        let closeImage = NSImage(named: "close")!
        closeImage.isTemplate = true
        let closeButton = ASButton(image: closeImage, hasBorder: false, color:Style.GradientLayerTextColors[UserDefaults.standard.integer(forKey: "styleID")], size: NSSize(width: 30, height: 30))
        window.contentView!.addSubview(closeButton)
        closeButton.rx.tap.subscribe(onNext: { [unowned self]() in
            self.hideHUD()
            }, onError: { (err) in
                
            }, onCompleted: {
                
        }) {
            }
            .addDisposableTo(disposeBag!)
        self.closeButton = closeButton
        
        
        var borderWidth = 0
        
        switch size {
        case .large:
            hudTextField.font = NSFont(name: (hudTextField.font?.fontName)!, size: 100)
            borderWidth = 5
            window.contentView?.layer?.cornerRadius = 30
        case .medium:
            hudTextField.font = NSFont(name: (hudTextField.font?.fontName)!, size: 60)
            borderWidth = 3
            window.contentView?.layer?.cornerRadius = 20
        case .small:
            hudTextField.font = NSFont(name: (hudTextField.font?.fontName)!, size: 20)
            borderWidth = 1
            window.contentView?.layer?.cornerRadius = 10
        }
        
        switch style {
        case .dark:
            hudTextField.textColor = NSColor.white
            window.contentView!.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.9).cgColor
            if bordered {
                window.contentView!.layer?.borderWidth = CGFloat(borderWidth)
                window.contentView!.layer?.borderColor = NSColor.white.cgColor
            } else {
                window.contentView!.layer?.borderWidth = 0
            }
        case .light:
            hudTextField.textColor = NSColor(red:0.15, green:0.16, blue:0.17, alpha:1.00)
            window.contentView!.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.9).cgColor
            if bordered {
                window.contentView!.layer?.borderWidth = CGFloat(borderWidth)
                window.contentView!.layer?.borderColor = NSColor(red:0.15, green:0.16, blue:0.17, alpha:1.00).cgColor
            } else {
                window.contentView!.layer?.borderWidth = 0
            }
        }
        
        if titleColor != nil {
            hudTextField.textColor = titleColor
        }
        
        if colors != nil {
            window.contentView!.layerContentsRedrawPolicy = .onSetNeedsDisplay
            window.contentView!.wantsLayer = true
            window.contentView!.layer = LayerHelper.createGradientLayer(frame: window.contentView!.frame, colors: colors!, startPoint: NSPoint(x:0,y:1), endPoint: NSPoint(x:1,y:0))
        }
        
        
        
        window.makeKey()
    }
    
    private func setupLayout( position: ASHUDPosition = .center) {
        
        
        
        constrain(window.contentView!) { (view) in
            view.left == view.superview!.left
            view.right == view.superview!.right
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
        }
        
        constrain(hudTextField!) { (view) in
            view.left == view.superview!.left + 40
            view.right == view.superview!.right - 90
            view.centerY == view.superview!.centerY
            view.height == self.hudTextField!.frame.height * 1.5
        }
        
        constrain(closeButton!) { (view) in
            view.centerY == view.superview!.centerY
            view.right == view.superview!.right
            view.width == self.hudTextField!.frame.height + 40
            view.height == self.hudTextField!.frame.height + 40
        }
        
        
        let sizeRect = NSSize(width: hudTextField!.frame.width + 40 + 50, height: hudTextField!.frame.height + 40)
        
        
        var displayBounds = NSRect(origin: NSScreen.main()!.frame.origin, size: sizeRect)
        
        switch position {
        case .bottom:
            displayBounds.origin.y += 50
        case .center:
            displayBounds.origin.y += (NSScreen.main()!.frame.height - sizeRect.height)/2
        case .top:
            displayBounds.origin.y += (NSScreen.main()!.frame.height - sizeRect.height - 50)
        }
        
        
        
        window.setFrame(displayBounds, display: true)
        window.makeKeyAndOrderFront(self)
        
        displayBounds.origin.x += (NSScreen.main()!.frame.width - window.frame.width)/2
        window.setFrame(displayBounds, display: true)
        
        
    }
    
    public func show(msg: String ,
              delayTime: TimeInterval = 3,
              position: ASHUDPosition = .center,
              size: ASHUDSize = .medium,
              style: ASHUDStyle = .dark,
              bordered: Bool = false,
              colors:[CGColor]? = nil,
              titleColor:NSColor? = nil
        ) {
        
        
        
        
        
        setupUI(msg:msg,
                size: size,
                style: style,
                bordered: bordered,
                colors: colors,
                titleColor: titleColor)
        
        setupLayout(position: position)
        
        if Double(delayTime) > 0 {
            delayTask = ASTimerUtils.delay(delayTime) { [unowned self] in
                self.hideHUD()
                }!
        }
        
        window.setIsVisible(true)
        window.contentView?.alphaValue = 0
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.1
            self.window.contentView?.animator().alphaValue = 1
        }) {
            
        }
    }
    
    public func hideHUD(_ fade: Bool = true) {
        
        guard fade else {
            window.orderOut(self)
            return
        }
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.2
            self.window.contentView?.animator().alphaValue = 0
        }) {
            self.window.orderOut(self)
            self.window.contentView?.alphaValue = 0
            self.dispose()
        }
        
    }
    
    private func dispose() {
        
        hudTextField?.removeFromSuperview()
        hudTextField = nil
        
        closeButton?.removeFromSuperview()
        closeButton = nil
        disposeBag = nil
        
        window.setIsVisible(false)
        
        if delayTask != nil {
            ASTimerUtils.cancel(delayTask)
            delayTask = nil
        }
        
    }
    
}

public enum ASHUDPosition:Int {
    case top,bottom,center
}

public enum ASHUDSize:Int {
    case small,medium,large
}

public enum ASHUDStyle:Int {
    case dark,light
}
