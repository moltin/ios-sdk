//
//  ViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 02/14/2017.
//  Copyright (c) 2017 Oliver Foggin. All rights reserved.
//

import UIKit
import Moltin
import AlamofireImage

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    
    var categories: [ProductCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "COLLECTIONS"
        
        setCartBarButtonItem()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        collectionView = {
            collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = .horizontal
            collectionViewLayout.minimumInteritemSpacing = 0
            collectionViewLayout.minimumLineSpacing = 0
            collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            let c = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
            c.translatesAutoresizingMaskIntoConstraints = false
            c.delegate = self
            c.dataSource = self
            c.isPagingEnabled = true
            c.showsVerticalScrollIndicator = false
            c.showsHorizontalScrollIndicator = false
            
            c.register(ProductCollectionCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
            
            c.backgroundColor = .white
            
            return c
        }()
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        let query = MoltinQuery(offset: nil, limit: nil, sort: nil, filter: nil, include: [.products])

        Moltin.category.list(withQuery: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categories):
                let filteredCategories = categories.filter { !$0.products.isEmpty }
                self.categories = filteredCategories
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! ProductCollectionCollectionViewCell
        
        let category = categories[indexPath.item]
        
        cell.collectionNameLabel.text = category.name
        
//        if let file = category.files.first {
//            cell.collectionImageView.af_setImage(withURL: file.url)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        
        let controller = ProductListViewController()
        controller.category = category
        
        show(controller, sender: nil)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

class ProductCollectionCollectionViewCell: UICollectionViewCell {
    let collectionNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.heuristicaItalic(size: 20)
        l.textColor = .darkGray
        l.numberOfLines = 0
        l.textAlignment = .center
        l.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        l.layer.cornerRadius = 4
        l.layer.masksToBounds = true
        return l
    }()
    
    let collectionImageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionImageView)
        collectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backgroundColor = .white
        
        addSubview(collectionNameLabel)
        
        collectionNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
