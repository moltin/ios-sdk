//
//  ImageGalleryViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 28/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

import Moltin
import AlamofireImage

class ImageGalleryViewController: UIViewController {
    var files: [File] = []
    
    let imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        i.heightAnchor.constraint(equalTo: i.widthAnchor, multiplier: 0.65).isActive = true
        return i
    }()
    
    lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 65, height: 65)
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = 2
        
        let c = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: l)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .white
        let constraint = c.heightAnchor.constraint(equalToConstant: 100)
        constraint.priority = 900
        constraint.isActive = true
        c.delegate = self
        c.dataSource = self
        c.register(ImageGalleryCell.self, forCellWithReuseIdentifier: "ImageCell")
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageStackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [imageView])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            s.alignment = .fill
            s.distribution = .fill
            s.isLayoutMarginsRelativeArrangement = true
            return s
        }()
        
        let stackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [imageStackView, collectionView])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.axis = .vertical
            s.distribution = .fill
            s.alignment = .fill
            s.isLayoutMarginsRelativeArrangement = true
            return s
        }()
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if let file = files.first {
            imageView.af_setImage(withURL: file.url)
        }
        
        if files.count <= 1 {
            collectionView.isHidden = true
        }
    }
}

extension ImageGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageGalleryCell
        
        let file = files[indexPath.item]
        
        cell.imageView.af_setImage(withURL: file.url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let file = files[indexPath.item]
        
        imageView.af_setImage(withURL: file.url)
    }
}

class ImageGalleryCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.clipsToBounds = true
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
