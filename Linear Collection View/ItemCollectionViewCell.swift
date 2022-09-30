//
//  ItemCollectionViewCell.swift
//  Linear Collection View
//
//  Created by Karen Natalia on 30/09/22.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 20
    }
    
    func setupValue(item: Item) {
        itemImage.image = UIImage(systemName: item.imageName)
        itemTitle.text = item.title
    }

}
