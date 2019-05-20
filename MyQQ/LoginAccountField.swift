//
//  LoginAccountField.swift
//  MyQQ
//
//  Created by Rion on 2019/5/20.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class LoginAccountField: NSTextField, NSTextFieldDelegate {
    
    private let placeholderText: String = "输入账号"

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        delegate = self
    }
    
    override func mouseDown(with event: NSEvent) {
        placeholderString = ""
        currentEditor()?.selectAll(nil)
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        placeholderString = placeholderText
    }
    
}
