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
    @IBOutlet weak var qrButton: NSButton!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet var qrView: NSView!
    
    lazy var settingWindow: NSWindow = {
        let window = NSWindow(contentRect: NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! - 100, (view.window?.frame.size.width)!, 100), styleMask: [.titled], backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.contentViewController = NSStoryboard(name: NSStoryboard.Name.init("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init("settingVC")) as! SettingViewController
        view.window?.addChildWindow(window, ordered: .below)
        
        window.backgroundColor = .white
        return window
    }()
    
    private let sound = NSSound(named: NSSound.Name.init("登录状态切换的音效.mp3"))
    
    //用户数据
    var userData = Array<String>()
    var itemRect: NSRect?
    lazy var transitionItem: LoginAvatarButton = {
        let button = LoginAvatarButton()
        button.target = self
        button.action = #selector(handleTransition(button:))
        button.isBordered = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSText.didChangeNotification, object: nil, queue: OperationQueue.main) { (notifi) in
                self.loginButton.isEnabled = !self.accountField.stringValue.isEmpty && !self.pwdField.stringValue.isEmpty
        }
        
        //qrView背景色修改，必须先将wantsLayer设置为true
        qrView.wantsLayer = true
        qrView.layer?.backgroundColor = .white
        
        //注册cell
        collectionView.register(NSNib?.init(NSNib.init(nibNamed: NSNib.Name.init("LoginUserItem"), bundle: nil)!), forItemWithIdentifier: NSUserInterfaceItemIdentifier.init("LoginUserItem"))

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        //赋值数据
        userData = ["2_01","2_02","2_03","2_04","2_05"]
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
        
        sound?.play()
        
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
    
    @IBAction func onQrcodeClick(_ sender: NSButton) {
        qrButton.isHidden = true
        view.addSubview(qrView)
    }
    
    @IBAction func onBackClick(_ sender: NSButton) {
        qrButton.isHidden = false
        qrView.removeFromSuperview()
    }
    
    
    
}

extension ViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init("LoginUserItem"), for: indexPath) as! LoginUserItem
        item.model = LoginUserItemModel(name: userData[indexPath.item])
        item.avatarClick = { [weak self] sender in
            self?.didClickAvatarItem(item, with: indexPath)
        }
        return item
    }
    
    func didClickAvatarItem(_ item: LoginUserItem, with indexPath: IndexPath) {
        itemRect = view.convert(item.view.frame, from: collectionView)
        transitionItem.frame = itemRect!
        transitionItem.image = NSImage(named: userData[indexPath.item])
        collectionView.isHidden = true
        view.addSubview(transitionItem)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            var temp = NSMakeRect(self.view.frame.width / 2, 0, 100, 100)
            temp = view.convert(temp, to: self.collectionView)
            self.transitionItem.animator().frame = temp
        }, completionHandler: nil)
    }
    
    @objc func handleTransition(button: LoginAvatarButton) {
        NSAnimationContext.runAnimationGroup ({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            self.transitionItem.animator().frame = self.itemRect!
        }) {
            self.collectionView.isHidden = false
            self.transitionItem.removeFromSuperview()
        }
    }
    
    
    
}
