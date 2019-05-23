//
//  FriendViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class FriendViewController: NSViewController {

    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var addFriendButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
        addFriendButton.wantsLayer = true
        addFriendButton.layer?.backgroundColor = NSColor.white.cgColor
        addFriendButton.bezelStyle = .regularSquare
        addFriendButton.isBordered = false
        addFriendButton.layer?.borderColor = NSColor.lightGray.cgColor
        addFriendButton.layer?.borderWidth = 1
        addFriendButton.layer?.cornerRadius = 4
        
    }
    
    @IBAction func onAddClick(_ sender: NSButton) {
        let menu = NSMenu(title: "add friend")
        menu.addItem(withTitle: "添加好友", action: #selector(handleMenu(item:)), keyEquivalent: "")
        menu.addItem(withTitle: "添加群", action: #selector(handleMenu(item:)), keyEquivalent: "")
        menu.addItem(withTitle: "创建群", action: #selector(handleMenu(item:)), keyEquivalent: "")
        sender.menu = menu
        NSMenu.popUpContextMenu(sender.menu!, with: NSEvent.mouseEvent(with: .leftMouseDown, location: sender.frame.origin, modifierFlags: NSEvent.ModifierFlags.control, timestamp: 0, windowNumber: sender.window!.windowNumber, context: sender.window?.graphicsContext, eventNumber: 0, clickCount: 1, pressure: 1)!, for: sender, with: nil)
//        sender.menu!.popUp(positioning: nil, at: sender.convert(sender.frame.origin, to: view), in: sender)
    }
    
    @objc func handleMenu(item: NSMenuItem) {
        print("000")
    }
    
}
