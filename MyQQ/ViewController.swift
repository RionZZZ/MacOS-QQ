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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSText.didChangeNotification, object: nil, queue: OperationQueue.main) { (notifi) in
                self.loginButton.isEnabled = !self.accountField.stringValue.isEmpty && !self.pwdField.stringValue.isEmpty
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
    
    

}

