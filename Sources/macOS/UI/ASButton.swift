//
//  ASButton.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation


public class ASButton: NSButton {
    
    private let overBg = NSView()
    private var titleTextField:NSTextField?
    private var icoImage:NSImageView?
    private var border:NSView?
    
    public override var isBordered: Bool {
        set {
            border?.isHidden = !newValue
            super.isBordered = newValue
        }
        get {
            return super.isBordered
        }
    }
    
    
    public init(_ title:String, hasBorder:Bool, color:ASColor, size:NSSize? = nil) {
        super.init(frame: NSRect.zero)
        init(title:title, image:nil, hasBorder:hasBorder, color:color, size:size)
    }
    
    public init(_ image:ASImage, hasBorder:Bool, color:ASColor, size:NSSize? = nil) {
        super.init(frame: NSRect.zero)
        init(title:nil, image:image, hasBorder:hasBorder, color:color, size:size)
    }
    
    public init(title:String?, image:ASImage?, hasBorder:Bool, color:ASColor, size:NSSize? = nil) {
        if size == nil {
            super.init(frame: NSRect.zero)
        } else {
            super.init(frame:NSRect(origin: CGPoint.zero, size: size!))
        }
        
        setupUI(title: title, image:image, hasBorder: hasBorder, color:color)
        setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title:String?,image:ASImage?,hasBorder:Bool,color:ASColor) {
        
        self.title = ""
        
        overBg.wantsLayer = true
        overBg.layer?.backgroundColor = ASColor.white.cgColor
        overBg.alphaValue = 0
        addSubview(overBg)
        
        if hasBorder {
            border = NSView()
            border!.wantsLayer = true
            border!.layer?.borderColor = ASColor.white.cgColor
            border!.layer?.borderWidth = 1
            addSubview(border!)
        }
        
        
        if title != nil {
            let titleTextField = NSTextField()
            titleTextField.backgroundColor = ASColor.clear
            titleTextField.drawsBackground = false
            titleTextField.wantsLayer = true
            titleTextField.layer?.backgroundColor = ASColor.clear.cgColor
            titleTextField.stringValue = title!
            titleTextField.isEditable = false
            titleTextField.isBezeled = false
            titleTextField.alignment = .center
            titleTextField.textColor = color
            if frame.height > 0 {
                titleTextField.font = NSFont.systemFont(ofSize: frame.size.height / 2)
            }
            addSubview(titleTextField)
            self.titleTextField = titleTextField
        }
        
        if image != nil {
            let icoImage = NSImageView()
            icoImage.image = image
            addSubview(icoImage)
            self.icoImage = icoImage
        }
    }
    
    private func setupLayout() {
        
        constrain(overBg) { (view) in
            view.edges == view.superview!.edges
        }
        
        if let border = self.border {
            constrain(border) { (view) in
                view.edges == view.superview!.edges
            }
        }
        
        if let titleTextField = self.titleTextField {
            constrain(titleTextField, block: { (view) in
                view.width == view.superview!.width
                view.center == view.superview!.center
            })
        }
        
        if let icoImage = self.icoImage {
            constrain(icoImage, block: { (view) in
                view.edges == view.superview!.edges
            })
        }
    }
    
    override public func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        overBg.alphaValue = 0.1
        window?.makeKeyAndOrderFront(nil)
    }
    override public func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        overBg.alphaValue = 0
    }
    override public func mouseDown(with event: NSEvent) {
        overBg.alphaValue = 0.3
        super.mouseDown(with: event)
        overBg.alphaValue = 0.1
    }
    override public func mouseUp(with event: NSEvent) {
        overBg.alphaValue = 0.1
        super.mouseUp(with: event)
    }
    override public func otherMouseUp(with event: NSEvent) {
        overBg.alphaValue = 0
        super.otherMouseUp(with: event)
    }
    override public func updateTrackingAreas() {
        addTrackingArea(NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited , .activeAlways], owner: self, userInfo: nil))
    }
}
