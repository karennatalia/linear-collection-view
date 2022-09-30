//
//  ItemCollectionViewCell.swift
//  Linear Collection View
//
//  Created by Karen Natalia on 30/09/22.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemImage: UIImageView!
    
    func setup(item: Item) {
        itemImage.image = UIImage(systemName: item.imageName)
        itemTitle.text = item.title
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 20
    }
}
