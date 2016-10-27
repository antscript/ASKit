//
//  ASSingleWindow.swift
//  Tick Tock Today
//
//  Created by AntScript on 10/23/16.
//  Copyright © 2016 antscript.com. All rights reserved.
//

import Cocoa
import Cartography

public class ASSingleWindow: NSWindowController, NSWindowDelegate{
    
    
    public static var shared:ASSingleWindow?
    
    
    private var mainView:NSView?
    private let size:NSSize
    private var titleLabel:NSTextField? = ASLabel("", fontSize: 12, color: NSColor.black.withAlphaComponent(0.6), aligment: .center)
    private var bgView:NSView? = NSView()
    
    public init(title:String, view:NSView, size:NSSize) {
        
        titleLabel?.stringValue = title
        mainView = view
        self.size = size
        
        
        
        let window = NSWindow(contentRect: NSRect(x:0, y:0, width:size.width, height:size.height) , styleMask: [.titled, .closable, .fullSizeContentView ], backing: .buffered, defer: true, screen: NSScreen.main()!)
        
        
        super.init(window: window)
        
        setupUI()
        setupLayout()
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        
        window?.backgroundColor = NSColor.white
        window?.hasShadow = true
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.delegate = self
        window?.center()
        
        bgView?.wantsLayer = true
        bgView?.layer = LayerHelper.createGradientLayer(frame: window!.contentView!.frame, colors: Style.GradientLayerColors[2], startPoint: Style.GradientLayerPoints.start, endPoint: Style.GradientLayerPoints.end)
        window?.contentView?.addSubview(bgView!)
        
        window?.contentView?.addSubview(mainView!)
        
        window?.contentView?.addSubview(titleLabel!)
        
    }
    
    private func setupLayout() {
        
        constrain(bgView!) { (view) in
            view.size == view.superview!.size
            view.center == view.superview!.center
        }
        
        constrain(mainView!) { (view) in
            view.size == view.superview!.size
            view.center == view.superview!.center
        }
        
        constrain(titleLabel!) { (view) in
            view.top == view.superview!.top + 5
            view.centerX == view.superview!.centerX
        }
    }
    
    private func windowWillClose(_ notification: Notification) {
        ASSingleWindow.hide()
    }
    private func windowDidResignMain(_ notification: Notification) {
        ASSingleWindow.hide()
    }
    
    
    public static func show(title:String, view:NSView, size:NSSize) {
        hide()
        ASSingleWindow.shared = ASSingleWindow(title: title, view: view, size: size)
        ASSingleWindow.shared?.showWindow(self)
        NSApp.activate(ignoringOtherApps: true)
    }
    public static func hide() {
        ASSingleWindow.shared?.mainView?.removeFromSuperview()
        ASSingleWindow.shared?.mainView = nil
        ASSingleWindow.shared?.titleLabel?.removeFromSuperview()
        ASSingleWindow.shared?.titleLabel = nil
        ASSingleWindow.shared?.bgView?.removeFromSuperview()
        ASSingleWindow.shared?.bgView = nil
        ASSingleWindow.shared?.window?.delegate = nil
        ASSingleWindow.shared?.close()
        ASSingleWindow.shared = nil
    }
}
