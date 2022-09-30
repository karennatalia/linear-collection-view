//
//  ViewController.swift
//  Linear Collection View
//
//  Created by Karen Natalia on 30/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var itemCollectionView: UICollectionView!
    var items: [Item] = [
        Item(title: "Heart", imageName: "heart.fill"),
        Item(title: "Smile", imageName: "face.smiling"),
        Item(title: "Sun", imageName: "sun.max"),
        Item(title: "Moon", imageName: "moon.fill"),
        Item(title: "Cloud", imageName: "cloud.fill"),
        Item(title: "Snow", imageName: "snowflake")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        itemCollectionView.collectionViewLayout = createLayout()
        itemCollectionView.isUserInteractionEnabled = false
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.5)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(view.bounds.width / 2), heightDimension: .absolute(220)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 40
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBAction func nextItem(_ sender: Any) {
        items.removeFirst()
        reloadWithAnimation()
    }
    
    @IBAction func resetItem(_ sender: Any) {
        let newItems: [Item] = [
            Item(title: "Heart", imageName: "heart.fill"),
            Item(title: "Smile", imageName: "face.smiling"),
            Item(title: "Sun", imageName: "sun.max"),
            Item(title: "Moon", imageName: "moon.fill"),
            Item(title: "Cloud", imageName: "cloud.fill"),
            Item(title: "Snow", imageName: "snowflake")
        ]
        
        items = newItems
        itemCollectionView.reloadData()
    }
    
    func reloadWithAnimation() {
        UIView.animate(withDuration: 1.5, delay: 2.0, options: .curveEaseIn, animations: { [self] in
            itemCollectionView.performBatchUpdates {
                itemCollectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
            }
        }, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.setup(item: items[indexPath.row])
        return cell
    }
}
