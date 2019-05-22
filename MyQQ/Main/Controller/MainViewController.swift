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
    @IBOutlet weak var messageButton: NSButton!
    @IBOutlet weak var friendButton: NSButton!
    @IBOutlet weak var applicationButton: NSButton!
    
    lazy var contentTab: NSTabView = {
        let tabView = NSTabView()
        tabView.tabViewType = .noTabsNoBorder
        tabView.tabViewBorderType = .none
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        //添加子视图
        let messageVC = NSStoryboard.init(name: "Main", bundle: nil).instantiateController(withIdentifier: "message") as! MessageViewController
        let message = NSTabViewItem(viewController: messageVC)
        tabView.addTabViewItem(message)
        
        let friendVC = NSStoryboard.init(name: "Main", bundle: nil).instantiateController(withIdentifier: "friend") as! FriendViewController
        let friend = NSTabViewItem(viewController: friendVC)
        tabView.addTabViewItem(friend)
        
        let applicationVC = NSStoryboard.init(name: "Main", bundle: nil).instantiateController(withIdentifier: "application") as! ApplicationViewController
        let application = NSTabViewItem(viewController: applicationVC)
        tabView.addTabViewItem(application)
        
        tabView.selectTabViewItem(at: 0)
        
        return tabView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        searchField.window?.makeFirstResponder(nil)
    }
    
    @IBAction func onTabButtonClick(_ sender: NSButton) {
        sender.state = .on
        switch sender.tag {
        case 101:
            friendButton.state = .off
            applicationButton.state = .off
            contentTab.selectTabViewItem(at: 0)
        case 102:
            messageButton.state = .off
            applicationButton.state = .off
            contentTab.selectTabViewItem(at: 1)
        case 103:
            messageButton.state = .off
            friendButton.state = .off
            contentTab.selectTabViewItem(at: 2)
        default:
            break
        }
    }
    
}

extension MainViewController {
    
    func setupUI() {
        toolBar.wantsLayer = true
        toolBar.layer?.backgroundColor = NSColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1).cgColor
        
        view.addSubview(contentTab)
        contentTab.topAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
        contentTab.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentTab.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentTab.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
}
