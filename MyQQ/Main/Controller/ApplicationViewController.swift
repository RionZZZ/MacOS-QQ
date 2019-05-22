//
//  ApplicationViewController.swift
//  MyQQ
//
//  Created by Rion on 2019/5/22.
//  Copyright © 2019 Rion. All rights reserved.
//

import Cocoa

class ApplicationViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    var dataArray: [ApplicationItemModel] = [
        ApplicationItemModel(image: "007", title: "好友动态1", content: "空间动态有更新"),
        ApplicationItemModel(image: "008", title: "好友动态2", content: "空间动态有更新"),
        ApplicationItemModel(image: "009", title: "好友动态3", content: "空间动态有更新"),
        ApplicationItemModel(image: "010", title: "好友动态4", content: "空间动态有更新"),
        ApplicationItemModel(image: "011", title: "好友动态5", content: "空间动态有更新"),
        ApplicationItemModel(image: "012", title: "好友动态6", content: "空间动态有更新")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
        collectionView.register(NSNib(nibNamed: "ApplicationCollectionItem", bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier("ApplicationCollectionItem"))
        //改变滚动条样式
        collectionView.enclosingScrollView?.scrollerStyle = .overlay
    }
    
    @IBAction func onIconClick(_ sender: NSButton) {
        switch sender.tag {
        case 1001:
            break
        case 1002:
            break
        case 1003:
            break
        case 1004:
            break
        case 1005:
            break
        case 1006:
            break
        default:
            break
        }
    }
    
    
}

extension ApplicationViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("ApplicationCollectionItem"), for: indexPath) as! ApplicationCollectionItem
        item.model = dataArray[indexPath.item]
        return item
    }
    
    //勾选selectabel，才能有点击事件
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let item = collectionView.item(at: indexPaths.first!) as! ApplicationCollectionItem
        performSegue(withIdentifier: NSStoryboardSegue.Identifier("applicationPush"), sender: item)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        let vc = segue.destinationController as! NSViewController
        let item = sender as! ApplicationCollectionItem
        vc.title = item.titleLabel.stringValue
    }
}
