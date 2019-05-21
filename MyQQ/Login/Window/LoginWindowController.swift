//
//  LoginWindowController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/10.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        //隐藏左上角三个按钮
        window?.standardWindowButton(.closeButton)?.isHidden = true
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window?.standardWindowButton(.zoomButton)?.isHidden = true
        
        //窗口移动
        window?.isMovableByWindowBackground = true
        
        //背景颜色
        window?.backgroundColor = .white
        
    }
    
    
    
    

}
