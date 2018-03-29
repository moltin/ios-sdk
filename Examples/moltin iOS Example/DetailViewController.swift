//
//  DetailViewController.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 21/02/2018.
//

import UIKit
import moltin

class DetailViewController: UIViewController {
    
    lazy var moltin: Moltin = {
        let config = MoltinConfig.default(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))
        return Moltin(withConfiguration: config)
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var category: ProductCategory?
    var products: [Product]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = category?.name
        
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width / 2
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        if let product = self.products?[indexPath.row] {
            
            cell.productName.text = product.name
            cell.productPrice.text = product.meta.displayPrice?.withTax.formatted
                
            self.moltin.product.include([.mainImage]).get(forID: product.id, completionHandler: { (result: Result<CustomProduct>) in
                switch result {
                case .success(let product):
                    DispatchQueue.main.async {
                        cell.productImage.load(urlString: product.mainImage?.link["href"])
                        cell.backgroundColor = product.backgroundColor
                    }
                default: break
                }
            })
        }
        
        return cell
    }
}

