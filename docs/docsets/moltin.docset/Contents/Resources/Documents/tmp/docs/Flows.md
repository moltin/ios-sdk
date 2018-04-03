# Flows

If you've implemented a custom field on a resource by using flows, you can cast this to a type of your choice by type-hinting your result, so long as this type conforms to `Codable`:

```swift
moltin.product.all { (result: Result<PaginatedResponse<[MyCustomProduct]>>) in
    switch result {
        case .success(let response):
            print(response.data) // [MyCustomProduct]
        case .failure(_):
            break
    }
}
```

```swift
moltin.product.get(forID: "<your ID>") { (result: Result<MyCustomProduct>) in
    switch result {
    case .success(let response):
        print(response) // MyCustomProduct
    case .failure(_):
        break
    }
```

We recommend ensuring that your types extend from our base types for safety, then you implement the `required init(from decoder: Decoder)`:

```swift
class MyCustomProduct: moltin.Product {
    let author: Author

    enum ProductCodingKeys : String, CodingKey { 
        case author 
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}
```

This will allow you to add additional types as you need, but ensures the base type, such as product, is still parsed correctly.