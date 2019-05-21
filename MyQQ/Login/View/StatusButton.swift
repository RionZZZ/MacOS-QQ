//
//  StatusButton.swift
//  MyQQ
//
//  Created by Rion on 2019/5/21.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class StatusButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        layer?.cornerRadius = dirtyRect.width / 2
        
    }
    
    
    
}
