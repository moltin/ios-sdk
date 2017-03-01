//
//  LoadingViewController.swift
//  Moltin
//
//  Created by Oliver Foggin on 01/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    let text: String
    
    init(text: String) {
        self.text = text
        
        super.init(nibName: nil, bundle: nil)
        
        definesPresentationContext = false
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        let loadingView: LoadingView = {
            let l = LoadingView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            l.label.text = text
            return l
        }()
        
        view.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

class LoadingView: UIView {
    let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.montserratRegular(size: 20)
        l.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        let stackView: UIStackView = {
            let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityView.translatesAutoresizingMaskIntoConstraints = false
            activityView.startAnimating()
            
            let s = UIStackView(arrangedSubviews: [activityView, label])
            s.translatesAutoresizingMaskIntoConstraints = false
            s.axis = .vertical
            s.spacing = 10
            s.alignment = .fill
            return s
        }()
        
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
