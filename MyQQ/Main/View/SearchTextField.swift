//
//  SearchTextField.swift
//  MyQQ
//
//  Created by Rion on 2019/5/21.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class SearchTextField: NSTextField {
    
    let searchImage = NSImageView(image: #imageLiteral(resourceName: "04"))

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        layer?.cornerRadius = dirtyRect.height / 2
        layer?.masksToBounds = true
        
        layer?.borderColor = .white
        layer?.borderWidth = 2.5
        
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchImage)
        searchImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 6).isActive = true
        searchImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        searchImage.widthAnchor.constraint(equalToConstant: dirtyRect.height).isActive = true

    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        searchImage.removeFromSuperview()
    }
    
}
