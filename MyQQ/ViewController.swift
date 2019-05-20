//
//  ViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/10.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var accountField: LoginAccountField!
    @IBOutlet weak var pwdField: LoginPwdField!
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var arrowButton: NSButton!
    
    lazy var settingWindow: NSWindow = {
        let window = NSWindow(contentRect: NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! - 100, (view.window?.frame.size.width)!, 100), styleMask: [.titled], backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.contentViewController = NSStoryboard(name: NSStoryboard.Name.init("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init("settingVC")) as! SettingViewController
        view.window?.addChildWindow(window, ordered: .below)
        return window
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSText.didChangeNotification, object: nil, queue: OperationQueue.main) { (notifi) in
                self.loginButton.isEnabled = !self.accountField.stringValue.isEmpty && !self.pwdField.stringValue.isEmpty
        }

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
//        self.settingWindow.setFrame(NSMakeRect((self.view.window?.frame.origin.x)!, (self.view.window?.frame.origin.y)! + 22, (self.view.window?.frame.size.width)!, 0), display: false)
//        self.view.window?.addChildWindow(self.settingWindow, ordered: .below)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        accountField.becomeFirstResponder()
        NotificationCenter.default.addObserver(forName: NSWindow.willMoveNotification, object: nil, queue: OperationQueue.main) { (notifi) in
            if self.arrowButton.state == .off {
                self.settingWindow.setFrame(NSMakeRect((self.view.window?.frame.origin.x)!, (self.view.window?.frame.origin.y)! + 22, (self.view.window?.frame.size.width)!, 0), display: false)
                self.view.window?.addChildWindow(self.settingWindow, ordered: .below)
            }
        }
        
        
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
    
    @IBAction func onLoginClick(_ sender: NSButton) {
    }
    
    @IBAction func onArrowClick(_ sender: NSButton) {
        
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.45
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            if sender.state == .on {
                settingWindow.animator().setFrame(NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! - 78, (view.window?.frame.size.width)!, 100), display: true)
                
                view.window?.addChildWindow(settingWindow, ordered: .below)
            } else {
                //            view.window?.removeChildWindow(settingWindow!)
                settingWindow.animator().setFrame(NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! + 22, (view.window?.frame.size.width)!, 0), display: false)
            }
        }
        
    }
    
}

