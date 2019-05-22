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
        let window = NSWindow(contentRect: NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! + 99, (view.window?.frame.size.width)!, 78), styleMask: [.titled], backing: NSWindow.BackingStoreType.buffered, defer: true)
        window.contentViewController = NSStoryboard(name: NSStoryboard.Name.init("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init("settingVC")) as! SettingViewController
        view.window?.addChildWindow(window, ordered: .below)
        
        window.backgroundColor = .white
        return window
    }()
    
    private let sound = NSSound(named: NSSound.Name.init("登录状态切换的音效.mp3"))
    
    //用户数据
    var userData = Array<LoginUserItemModel>()
    var itemRect: NSRect?
    lazy var transitionItem: LoginAvatarButton = {
        let button = LoginAvatarButton()
        button.target = self
        button.action = #selector(handleTransition(button:))
        button.isBordered = false
        button.imageScaling = .scaleAxesIndependently
        return button
    }()
    
    let statusButtonHeight: CGFloat = 16
    lazy var statusButton: StatusButton = {
       let button = StatusButton()
        button.image = #imageLiteral(resourceName: "online_status")
        button.isBordered = false
        button.imageScaling = .scaleAxesIndependently
        button.target = self
        button.action = #selector(changeStatusButton(button:))
        
        //修改约束必须加上此属性，配合.isActive=true使用
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSText.didChangeNotification, object: nil, queue: OperationQueue.main) { (notifi) in
            self.checkLoginType()
        }
        
        //qrView背景色修改，必须先将wantsLayer设置为true
        qrView.wantsLayer = true
        qrView.layer?.backgroundColor = .white
        
        //注册cell
        collectionView.register(NSNib?.init(NSNib.init(nibNamed: NSNib.Name.init("LoginUserItem"), bundle: nil)!), forItemWithIdentifier: NSUserInterfaceItemIdentifier.init("LoginUserItem"))

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        checkLoginType()
        
        //赋值数据
        for i in 1...5 {
            userData.append(LoginUserItemModel(name: "2_0\(i)"))
        }
        
        //设置进入后显示默认账号
        let firstIndex = IndexPath(item: 0, section: 0)
        let firstItem = collectionView.item(at: firstIndex)
        itemRect = view.convert((firstItem?.view.frame)!, from: collectionView)
        transitionItem.frame = itemRect!
        transitionItem.image = NSImage(named: userData[firstIndex.item].name)
        collectionView.isHidden = true
        view.addSubview(transitionItem)
        
        var temp = NSMakeRect(self.view.frame.width / 2, 0, 100, 100)
        temp = view.convert(temp, to: collectionView)
        transitionItem.frame = temp
        
        //显示状态按钮
        appendStatusButton()
        
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
    
    //点击登录按钮切换主窗口
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToMain" {
            view.window?.close()
        }
    }
    
    func checkLoginType() {
        loginButton.isEnabled = !accountField.stringValue.isEmpty && !pwdField.stringValue.isEmpty
    }

    @IBAction func onCloseClick(_ sender: Any) {
//        NSApplication.shared.terminate(sender)
//        NSApp  ==  NSApplication.shared
        NSApp.terminate(sender)
    }
    
//    @IBAction func onLoginClick(_ sender: NSButton) {
//        view.window?.close()
//    }
    
    @IBAction func onArrowClick(_ sender: NSButton) {
        
        sound?.play()
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 0.45
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            if sender.state == .on {
                settingWindow.animator().setFrame(NSMakeRect((view.window?.frame.origin.x)!, (view.window?.frame.origin.y)! - 78, (view.window?.frame.size.width)!, 100), display: true)
                
                view.window?.addChildWindow(settingWindow, ordered: .below)
            } else {
//                view.window?.removeChildWindow(settingWindow)
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
        item.model = userData[indexPath.item]
        
        //闭包传值
        item.avatarClick = { [weak self] in
            self?.didClickAvatarItem(item, with: indexPath)
        }
        
        //代理协议
        item.delegate = self
        
        return item
    }
    
    func didClickAvatarItem(_ item: LoginUserItem, with indexPath: IndexPath) {
        itemRect = view.convert(item.view.frame, from: collectionView)
        transitionItem.frame = itemRect!
        transitionItem.image = NSImage(named: userData[indexPath.item].name)
        collectionView.isHidden = true
        view.addSubview(transitionItem)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            var temp = NSMakeRect(self.view.frame.width / 2, 0, 100, 100)
            temp = view.convert(temp, to: self.collectionView)
            self.transitionItem.animator().frame = temp
        }, completionHandler: {
            self.appendStatusButton()
        })
    }
    
    @objc func handleTransition(button: LoginAvatarButton) {
        NSAnimationContext.runAnimationGroup ({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            self.statusButton.isHidden = true
            self.transitionItem.animator().frame = self.itemRect!
        }) {
            self.collectionView.isHidden = false
            self.transitionItem.removeFromSuperview()
        }
    }
    
    func appendStatusButton() {
        self.statusButton.isHidden = false
        self.view.addSubview(self.statusButton)
        self.statusButton.bottomAnchor.constraint(equalTo: self.transitionItem.bottomAnchor, constant: self.statusButtonHeight / 2).isActive = true
        self.statusButton.heightAnchor.constraint(equalToConstant: self.statusButtonHeight).isActive = true
        self.statusButton.widthAnchor.constraint(equalToConstant: self.statusButtonHeight).isActive = true
        self.statusButton.centerXAnchor.constraint(equalTo: self.transitionItem.centerXAnchor).isActive = true
    }
    
    @objc func changeStatusButton(button: NSButton) {
        button.image = button.image == #imageLiteral(resourceName: "online_status") ? #imageLiteral(resourceName: "hide_status") : #imageLiteral(resourceName: "online_status")
    }
    
    
}

extension ViewController: LoginUserItemDelegate {
    
    func removeUserItem(_ item: LoginUserItem) {
        let indexPath = collectionView.indexPath(for: item)
        collectionView.deleteItems(at: [indexPath!])
        userData.remove(at: indexPath!.item)
        collectionView.reloadData()
    }
    
}
