//
//  ProductDetailViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 28/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

import Moltin

class ProductDetailViewController: UIViewController {
    var category: ProductCategory!
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PRODUCT"
        
        view.backgroundColor = .white
        setCartBarButtonItem()
        
        let imageGallery: ImageGalleryViewController = {
            let i = ImageGalleryViewController()
            i.files = product.files
            return i
        }()
        
        let categoryNameLabel: UILabel = {
            let l = UILabel()
            l.translatesAutoresizingMaskIntoConstraints = false
            l.font = UIFont.montserratBlack(size: 14)
            l.textColor = .lightGray
            l.text = category.name
            return l
        }()
        
        let productLabelStackView: UIStackView = {
            let productNameLabel: UILabel = {
                let l = UILabel()
                l.translatesAutoresizingMaskIntoConstraints = false
                l.font = UIFont.montserratBlack(size: 22)
                l.text = product.name
                l.numberOfLines = 2
                return l
            }()
            
            let priceLabel: UILabel = {
                let l = UILabel()
                l.translatesAutoresizingMaskIntoConstraints = false
                l.font = UIFont.montserratBlack(size: 22)
                l.textColor = UIColor(red:0.62, green:0.49, blue:0.75, alpha:1.00)
                l.text = product.displayPriceWithTax?.formatted
                l.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
                l.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
                return l
            }()
            
            let s = UIStackView(arrangedSubviews: [productNameLabel, priceLabel])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.axis = .horizontal
            s.spacing = 8
            s.distribution = .fill
            s.alignment = .lastBaseline
            s.isLayoutMarginsRelativeArrangement = true
            return s
        }()
        
        let descriptionLabel: UILabel = {
            let l = UILabel()
            l.translatesAutoresizingMaskIntoConstraints = false
            l.numberOfLines = 0
            l.font = UIFont.heuristicaRegular(size: 14)
            l.textColor = .lightGray
            l.text = product.description
            return l
        }()
        
        let addToCartButton: UIButton = {
            let b = UIButton(type: .custom)
            b.translatesAutoresizingMaskIntoConstraints = false
            b.setTitle("Add to cart", for: .normal)
            b.addTarget(self, action: #selector(addProductToCart), for: .touchUpInside)
            b.backgroundColor = UIColor(red:0.62, green:0.49, blue:0.75, alpha:1.00)
            b.heightAnchor.constraint(equalToConstant: 44).isActive = true
            b.layer.cornerRadius = 22
            b.layer.masksToBounds = true
            return b
        }()
        
        let mainStackView: UIStackView = {
            let s = UIStackView(arrangedSubviews: [imageGallery.view, categoryNameLabel, productLabelStackView, descriptionLabel, addToCartButton])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.spacing = 10
            s.axis = .vertical
            s.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
            s.isLayoutMarginsRelativeArrangement = true
            return s
        }()
        
        let scrollView: UIScrollView = {
            let s = UIScrollView()
            s.translatesAutoresizingMaskIntoConstraints = false
            s.addSubview(mainStackView)
            
            mainStackView.leadingAnchor.constraint(equalTo: s.leadingAnchor).isActive = true
            mainStackView.trailingAnchor.constraint(equalTo: s.trailingAnchor).isActive = true
            mainStackView.topAnchor.constraint(equalTo: s.topAnchor).isActive = true
            mainStackView.bottomAnchor.constraint(equalTo: s.bottomAnchor).isActive = true
            
            return s
        }()
        
        addChildViewController(imageGallery)
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func addProductToCart() {
        guard let reference = CartViewController.cartReference else {
            Moltin.cart.getNew { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let cart):
                    guard let actualCart = cart else {
                        return
                    }
                    
                    CartViewController.cartReference = actualCart.id
                    self.addProductToCart()
                }
            }
            
            return
        }
        
        Moltin.cart.add(itemWithProductID: product.id, andQuantity: 1, toCartID: reference) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                self.showCart()
            }
        }
    }
}
