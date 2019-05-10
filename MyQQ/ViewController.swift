//
//  ViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/10.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override var representedObject: Any? {
        didSet {
            
        }
    }

    @IBAction func onCloseClick(_ sender: Any) {
//        NSApplication.shared.terminate(sender)
//        NSApp  ==  NSApplication.shared
        NSApp.terminate(sender)
    }
    
    
    

}

