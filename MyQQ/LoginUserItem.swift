//
//  LoginUserItem.swift
//  MyQQ
//
//  Created by Rion on 2019/5/20.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class LoginUserItem: NSCollectionViewItem {

    @IBOutlet weak var imageButton: LoginAvatarButton!
    
    var model: LoginUserItemModel! {
        didSet {
            imageButton.image = NSImage(named: NSImage.Name(model.name))
        }
    }
    var avatarClick: ((_ sender: Any) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onAvatarClick(_ sender: Any) {
        avatarClick?(sender)
    }
    
    
    
}
