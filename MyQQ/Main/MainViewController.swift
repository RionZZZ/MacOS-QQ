//
//  MainViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/21.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var toolBar: NSView!
    @IBOutlet weak var searchField: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        searchField.window?.makeFirstResponder(nil)
    }
    
    
}

extension MainViewController {
    
    func setupUI() {
        toolBar.wantsLayer = true
        toolBar.layer?.backgroundColor = NSColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
    }
}
