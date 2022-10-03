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
        
        self.layer.cornerRadius = 20
        self.contentView.backgroundColor = .systemGray6
    }
    
    func setupValue(item: Item) {
        itemImage.image = UIImage(systemName: item.imageName)
        itemTitle.text = item.title
    }
    
    func makeHidden() {
        self.contentView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [self] in
            self.contentView.alpha = 0
        }, completion: nil)
    }

}
