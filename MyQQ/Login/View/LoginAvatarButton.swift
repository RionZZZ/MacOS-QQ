//
//  LoginAvatarButton.swift
//  MyQQ
//
//  Created by Rion on 2019/5/10.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class LoginAvatarButton: NSButton {
    
    let defaultColor = NSColor(red: 0.72, green: 0.75, blue: 0.77, alpha: 1)
    let mouseEnterColor = NSColor(red: 0.44, green: 0.84, blue: 0.95, alpha: 1)
    let borderWidth: CGFloat = 1
    let mouseEnterWidth: CGFloat = 2

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        layer?.cornerRadius = dirtyRect.width / 2
        imageScaling = .scaleAxesIndependently
        
        let trackingArea = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeInActiveApp], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
        
//        layer?.borderColor = defaultColor.cgColor
//        layer?.borderWidth = borderWidth
        changeBorder(defaultColor, borderWidth)
    }
    
    override func mouseEntered(with event: NSEvent) {
//        layer?.borderColor = mouseEnterColor.cgColor
//        layer?.borderWidth = mouseEnterWidth
        changeBorder(mouseEnterColor, mouseEnterWidth)
    }
    
    override func mouseExited(with event: NSEvent) {
//        layer?.borderColor = defaultColor.cgColor
//        layer?.borderWidth = borderWidth
        changeBorder(defaultColor, borderWidth)
    }
    
    func changeBorder(_ color: NSColor, _ width: CGFloat) {
        layer?.borderColor = color.cgColor
        layer?.borderWidth = width
    }
    
}
