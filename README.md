<img src="https://www.elasticpath.com/themes/custom/bootstrap_sass/logo.svg" alt="" width="400" />

# Elastic Path Commerce Cloud iOS Swift SDK

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Moltin.svg)](https://img.shields.io/cocoapods/v/Moltin.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![follow on Twitter](https://img.shields.io/twitter/follow/elasticpath?style=social&logo=twitter)](https://twitter.com/intent/follow?screen_name=elasticpath)

> A simple to use iOS/tvOS/watchOS SDK to help get you off the ground quickly and efficiently with your Elastic Path Commerce Cloud written in Swift.

📚 [API reference](https://documentation.elasticpath.com/commerce-cloud/docs/developer/get-started/sdk.html#officially-supported-sdk) &mdash; 📚 [Elastic Path Commerce Cloud](https://www.elasticpath.com)

# Requirements

- iOS 10.0+ / tvOS 10.0+ / watchOS 3.0+
- Swift 4.0+

# Installation

## Cocoapods

Add the following to your `Podfile`:
```
pod 'Moltin', '~> 3.1.2'
```

Or, quickly try out our examples:
```bash
pod try Moltin
```
## Carthage

Add the following to your `Cartfile`:
```
github "Moltin/ios-sdk" ~> 3.1.2
```
## Swift Package Manager

Add the following to your `dependencies` value in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/moltin/ios-sdk.git", from: "3.1.2")
]
```

# Usage

## Making a request
```swift
let moltin = Moltin(withClientID: "<your client ID>")

moltin.product.all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}

moltin.product.get("<product ID>") { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}

moltin.product.tree { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Checking out & Payment

Paying for a cart is a two step process in Moltin.

First, check out your cart, which will return you an order:

```swift
self.moltin.cart.checkout(
    cart: ...,
    withCustomer: ...,
    withBillingAddress: ...,
    withShippingAddress: ...) { (result) in
    switch result {
        case .success(let order):
            ...
        default: break
    }
}
```

Now that you have an order, you can pay for your order. Moltin providers several gateways for you to use:

- Stripe
- BrainTree
- Adyen
- Manual

Once you've chosen your payment gateway, you can fulfil one of Moltin's `PaymentMethod`'s:

```swift
let paymentMethod = StripeToken(withStripeToken: ...)
```

You can then use this payment method to pay for an order:

```swift
self.moltin.cart.pay(
    forOrderID: order.id,
    withPaymentMethod: paymentMethod) { (result) in
    ...
}
```

## Config

The basic way to set up the Moltin SDK is to create an instance of the `Moltin` class with your client ID and optionally the locale of the application. However, if you'd like to change additional details of the SDK, such as the URL of your `Moltin` instance, you can do so by passing in `MoltinConfig`.

```swift
let moltin = Moltin(withClientID: ...) // Takes Locale.current
```

```swift
let moltin = Moltin(withClientID: ..., withLocale: ...)
```

```swift
let config = MoltinConfig(
    clientID: ...,
    scheme: ...,
    host: ...,
    version: ...,
    locale: ...)

let moltin = Moltin(withConfiguration: config)
```
Or:
```swift
let config = MoltinConfig.default(
    withClientID: ...,
    withLocale: ...)

let moltin = Moltin(withConfiguration: config)
```

## Available Resources
- Brands
- Carts
- Categories
- Collections
- Currencies
- Files
- Flows
- Fields
- Entries
- Products

# Authentication

Authentication is handled silently for you as part of the SDK. The SDK will cache credentials to ensure that it is not making unnecessary requests.

The iOS SDK only supports `Implicit` authentication currently.

# Filtering

## Operations
- Filter
- Sort
- Offset / Limit
- Include

## Filter
```swift
moltin.product.filter(operator: .eq, key: "name", value: "ProductName").all {
   ...
}
```

## Sort
```swift
moltin.product.sort("order").all {
   ...
}
```
```swift
moltin.product.sort("-order").all {
   ...
}
```

## Offset / Limit

```swift
moltin.product.limit(10).offset(20).all {
    ...
}
```

## Include

```swift
moltin.product.include([.mainImage, .files]).all {
    ...
}
```

## Combining Operations

```swift
moltin.product.sort("-name").include([.mainImage]).limit(20).all {
   ...
}
```

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

# Examples

The Swift SDK is a community-supported software development kit for Elastic Path Commerce Cloud (formerly Moltin). The following examples show you how to use the SDK to make requests to the Commerce Cloud APIs.

For details about the endpoints, objects, and responses, see the [Elastic Path Commerce API Reference](https://documentation.elasticpath.com/commerce-cloud/docs/api/index.html).

- [Basics](#basics)
    - [Includes](#includes)
    - [Pagination](#pagination)
    - [Filtering](#filtering)
    - [Sorting](#sorting)
    - [Tokens](#tokens)
- [Currency](#currency)
- [Products](#products)
- [Brands](#brands)
- [Categories](#categories)
- [Collections](#collections)
- [Carts](#carts)
- [Customers](#customers)
- [Payments](#payments)

## Basics

### Includes

Examples of using `include` with resources. For more information, see [Includes](https://documentation.elasticpath.com/commerce-cloud/docs/api/basics/includes.html).

#### Include category products

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.category.include([.products]).get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

#### Include product main_image

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.product.include([.main_image]).all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

#### Multiple includes

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.product.include([.main_image, .category]).all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Pagination

Examples of using pagination with resources. For more information, see [Pagination](https://documentation.elasticpath.com/commerce-cloud/docs/api/basics/pagination.html).

#### Get all categories, two per page

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.limit(2).all {
  // Do something
}
```

#### Get products 21-30

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.limit(10).offset(20).all {
  // Do something
}
```

### Filtering

Examples of using different `filter` operators. For more information, see [Filtering](https://documentation.elasticpath.com/commerce-cloud/docs/api/basics/filtering.html).

#### The `eq` operator

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.filter(operator: .eq, key: "commodity_type", value: "digital").all {
  // Do something
}
```

#### The `like` operator - A string *begins with* a specified value

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.filter(operator: .like, key: "sku", value: "SHOE_DECK_*").all {
  // Do something
}
```

#### The `like` operator - A string *contains* a specified value

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.filter(operator: .like, key: "sku", value: "*_DECK_*").all {
  // Do something
}
```

#### The `like` operator - A string *ends with* a specified value

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.filter(operator: .like, key: "sku", value: "*_RED").all {
  // Do something
}
```

#### Chaining multiple operators

Caution: This feature is currently in **Beta** and you should expect it to change.

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product
  .filter(operator: .eq, key: "commodity_type", value: "physical")
  .sort("created_at")
  .all {
  // Do something
}
```

### Sorting

Examples of using `sort` with resources. For more information, see [Sorting](https://documentation.elasticpath.com/commerce-cloud/docs/api/basics/sorting.html).

#### Sort products by `created_at` in ascending order

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.sort("created_at").all {
  // Do something
}
```

#### Sort products by `created_at` in descending order

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.sort("-created_at").all {
  // Do something
}
```

### Tokens

#### Get an implicit access token

An `implicit` token can be thought of as a **Read only** token.

```swift
let moltin = Moltin(withClientID: "<your client ID>")
```

## Currency

### Get a currency

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.currency.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Get all currencies

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.currency.all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```


## Products

### Get all products

```swift
let moltin = Moltin(withClientID: "<your client ID>")
self.moltin.product.include([.mainImage]).all { (result: Result<PaginatedResponse<[moltin.Product]>>) in
   switch result {
       case .success(let response):
            DispatchQueue.main.async {
                self.products = response.data ?? []
            }
        case .failure(let error):
            print("Products error", error)
        }
    }
}
```

### Get all products that belong to a category

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.product.filter(operator: .eq, key: "category.id", value: "xxxx").all {
response in
// Do something
}
```

### Get a product

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.product.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Brands

### Get all brands

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.brand.all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Get a brand

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.brand.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Categories

### Get all categories

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.category.all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Get a category

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.category.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Get the categories tree

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.category.tree { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Collections

### Get all collections

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.collection.all { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

### Get a collection

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.collection.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Carts

### Get a cart

```swift
let moltin = Moltin(withClientID: "<your client ID>")
self.moltin.cart.get(forID: AppDelegate.cartID, completionHandler: { (result) in
    switch result {
        case .success(let result):
            DispatchQueue.main.async {
                print("Cart:", result)
                }
            case .failure(let error):
                print("Cart error:", error)
            }
    })
```

### Get cart items

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let referenceId = 'XXXX'
self.moltin.cart.items(forCartID: referenceId) { (result) in
    switch result {
        case .success(let result):
            DispatchQueue.main.async {
                 print("Cart items:", result.data)
            }
            case .failure(let error):
                print("Cart error:", error)
            }
        }
    }
```

### Add a product to a cart

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let referenceId = 'XXXX'
let productId = 'XXXX'
let productQty = 'XXXX'
self.moltin.cart.addProduct(withID: productId , ofQuantity: productQty, toCart: referenceId, completionHandler: { (_) in
})
```

### Add a promotion to a cart

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let referenceId = 'XXXX'
self.moltin.cart.addPromotion(code, toCart: referenceId) { (result) in
    switch result {
        case .success(let status):
            DispatchQueue.main.async {
                print("Promotion: (status)")
            }
            default: break
            }
        }
}
```

### Check out a cart

```swift
let moltin = Moltin(withClientID: "<your client ID>")
moltin.cart.checkout(
    cart: ...,
    withCustomer: ...,
    withBillingAddress: ...,
    withShippingAddress: ...) { (result) in
    switch result {
        case .success(let order):
            ...
        default: break
    }
}
```

### Delete a cart

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let referenceId = 'XXXX'
self.moltin.cart.deleteCart(referenceId, completionHandler: { (result)    in
    switch result {
        case .success(let result):
            print("Cart error:", result)
        case .failure(let error):
            print("Cart error:", error)
        }
})
```

## Customers

### Get a customer

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
moltin.customer.get(forID: id) { result in
    switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error)
    }
}
```

## Payments

### Create a Stripe payment

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let paymentMethod = StripeToken(withStripeToken: ...)
moltin.cart.pay(
    forOrderID: order.id,
    withPaymentMethod: paymentMethod) { (result) in
    ...
}
```

### Create a manually authorize payment

```swift
let moltin = Moltin(withClientID: "<your client ID>")
let id = "XXXX"
let paymentMethod = ManuallyAuthorizePayment()
moltin.cart.pay(forOrderID: order.id, withPaymentMethod: paymentMethod) { (result) in
    switch result {
        case .success:
            print("Success")
        case .failure(let error):
            print(error)
    }
}
```

# Further Documentation

Find more general documentation on the [API docs](https://documentation.elasticpath.com/commerce-cloud/docs/api/index.html).

# Communication

- If you need help with the SDK or the platform, get in touch on the [forum](https://forum.moltin.com)
- If you found a bug with the SDK, open an issue on GitHub
- If you have a feature request for the SDK, open an issue.
- If you want to contribute to the SDK, submit a pull request.


# License

Moltin is available under the MIT license. See the LICENSE file for more info.
