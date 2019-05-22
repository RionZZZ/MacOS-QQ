//
//  IconsStackView.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class IconsStackView: NSStackView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let trackingArea = NSTrackingArea(rect: bounds, options: [.activeAlways, .mouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)

    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        viewChange(views: views, state: .on, color: NSColor(red:  0, green: 0.73, blue: 0.94, alpha: 1))
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        viewChange(views: views, state: .off, color: NSColor(red: 119 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1))
    }
    
    private func viewChange(views: [NSView], state: NSControl.StateValue, color: NSColor) {
        for view in views {
            if view.isKind(of: NSButton.self) {
                let button = view as! NSButton
                button.state = state
            }
            
            if view.isKind(of: NSTextField.self) {
                let textField = view as! NSTextField
                textField.textColor = color
            }
        }
    }
    
}
