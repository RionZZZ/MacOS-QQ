//
//  FriendSplitView.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class FriendSplitView: NSSplitView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override var dividerColor: NSColor {
        return NSColor(red:0.96, green:0.97, blue:0.98, alpha:1.00)
    }
    
}
