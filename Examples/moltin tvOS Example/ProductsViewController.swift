//
//  ProductsViewController.swift
//  moltin tvOS Example
//
//  Created by Craig Tweedy on 21/03/2018.
//

import UIKit
import moltin

class ProductsViewController: UICollectionViewController {
    
    var data: [Product] = []
    let moltin: Moltin = Moltin(withClientID: "bJp5DRgPSrXFCft3AEWeJpX3pNU7A6dc0cfgi7K9Yd")
    var request: MoltinRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView?.register(UINib(nibName: "ProductCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        
        self.request = self.moltin.product.all { (response) in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    self.data = products.data ?? []
                    self.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - Data Source
extension ProductsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}


// MARK: - Delegate
extension ProductsViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = self.data[indexPath.row]
        cell.label.text = product.name
        
        return cell
    }
}
