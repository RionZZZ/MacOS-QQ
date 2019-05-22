//
//  ApplicationViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class ApplicationViewController: NSViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
    }
    
    @IBAction func onIconClick(_ sender: NSButton) {
        switch sender.tag {
        case 1001:
            break
        case 1002:
            break
        case 1003:
            break
        case 1004:
            break
        case 1005:
            break
        case 1006:
            break
        default:
            break
        }
    }
    
    
}
