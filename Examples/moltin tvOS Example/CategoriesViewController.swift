//
//  ProductsViewController.swift
//  moltin tvOS Example
//
//  Created by Craig Tweedy on 21/03/2018.
//

import UIKit
import moltin

extension UIImageView {

    func load(urlString string: String?) {
        guard let imageUrl = string,
            let url = URL(string: imageUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            }.resume()
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}

class ProductCategory: moltin.Category {
    var backgroundColor: UIColor?
    var backgroundImage: String?

    enum ProductCategoryCodingKeys: String, CodingKey {
        case backgroundColor = "background_colour"
        case backgroundImage = "background_image"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCategoryCodingKeys.self)
        if let color: String = try container.decodeIfPresent(String.self, forKey: .backgroundColor) {
            self.backgroundColor = UIColor(hexString: color)
        }
        self.backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage)
        try super.init(from: decoder)
    }
}

class CategoriesViewController: UICollectionViewController {

    var data: [ProductCategory] = []
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.collectionView?.register(UINib(nibName: "ProductCategoryCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.8)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.collectionView?.setCollectionViewLayout(flowLayout, animated: false)

        self.moltin.category.all { (response: Result<PaginatedResponse<[ProductCategory]>>) in
            switch response {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.view.backgroundColor = categories.data?.first?.backgroundColor
                    self.data = categories.data ?? []
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryToProducts",
            let viewController = segue.destination as? ProductsCollectionViewController,
            let category = sender as? ProductCategory {
            viewController.category = category
        }
    }

}

// MARK: - Data Source
extension CategoriesViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}

// MARK: - Delegate
extension CategoriesViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ProductCategoryCollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = self.data[indexPath.row]
        cell.backgroundColor = product.backgroundColor
        cell.image.load(urlString: product.backgroundImage)
        cell.label.text = product.name

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.data[indexPath.row]
        self.performSegue(withIdentifier: "CategoryToProducts", sender: category)
    }
}
