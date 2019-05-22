//
//  ApplicationCollectionItem.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class ApplicationCollectionItem: NSCollectionViewItem {

    @IBOutlet weak var image: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var contentLabel: NSTextField!
    
    var model: ApplicationItemModel! {
        didSet {
            image.image = NSImage(named: model.image)
            titleLabel.stringValue = model.title
            contentLabel.stringValue = model.content
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackingArea = NSTrackingArea(rect: view.bounds, options: [.activeAlways, .mouseEnteredAndExited], owner: self, userInfo: nil)
        view.addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        view.layer?.borderWidth = 1
        view.layer?.borderColor = NSColor(red:  0, green: 0.73, blue: 0.94, alpha: 1).cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        view.layer?.borderWidth = 0
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        view.layer?.backgroundColor = .white
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        view.layer?.backgroundColor = NSColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1).cgColor
    }
    
}
