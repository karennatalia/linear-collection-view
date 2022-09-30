//
//  ViewController.swift
//  Linear Collection View
//
//  Created by Karen Natalia on 30/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Item", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(nextItem), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset Item", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(resetItem), for: .touchUpInside)
        return button
    }()
    
    var items: [Item] = [
        Item(title: "Heart", imageName: "heart.fill"),
        Item(title: "Smile", imageName: "face.smiling"),
        Item(title: "Sun", imageName: "sun.max"),
        Item(title: "Moon", imageName: "moon.fill"),
        Item(title: "Cloud", imageName: "cloud.fill"),
        Item(title: "Snow", imageName: "snowflake")
    ]
    let cellID = "itemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup()
        setupUI()
        setupConstraints()
    }
    
    func collectionViewSetup() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
        itemCollectionView.collectionViewLayout = createLayout()
        itemCollectionView.isUserInteractionEnabled = false
        
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(itemCollectionView)
        view.addSubview(nextButton)
        view.addSubview(resetButton)
    }
    
    func setupConstraints() {
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            itemCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            itemCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            itemCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 3)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: itemCollectionView.bottomAnchor, constant: 24)
        ])
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 24)
        ])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.5)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(view.bounds.width / 2), heightDimension: .absolute(220)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 40
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc func nextItem(_ sender: Any) {
        items.removeFirst()
        reloadWithAnimation()
    }
    
    @objc func resetItem(_ sender: Any) {
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
        cell.setupValue(item: items[indexPath.row])
        return cell
    }
}
