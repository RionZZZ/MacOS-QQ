//
//  LoginUserItem.swift
//  MyQQ
//
//  Created by Rion on 2019/5/20.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

protocol LoginUserItemDelegate {
    func removeUserItem(_ item: LoginUserItem)
}

class LoginUserItem: NSCollectionViewItem {

    @IBOutlet weak var imageButton: LoginAvatarButton!
    @IBOutlet weak var closeButton: NSButton!
    
    var model: LoginUserItemModel! {
        didSet {
            imageButton.image = NSImage(named: NSImage.Name(model.name))
        }
    }
    var avatarClick: (()->())?
    var delegate: LoginUserItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackingArea = NSTrackingArea(rect: view.bounds, options: [.activeInActiveApp, .mouseEnteredAndExited], owner: self, userInfo: nil)
        view.addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        closeButton.isHidden = false
    }
    
    override func mouseExited(with event: NSEvent) {
        closeButton.isHidden = true
    }
    
    
    @IBAction func onAvatarClick(_ sender: Any) {
        //闭包传值
        avatarClick?()
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        //代理传值
        if let delegate = delegate {
            delegate.removeUserItem(self)
        }
    }
    
    
}
