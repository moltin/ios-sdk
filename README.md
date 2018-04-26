# Moltin iOS SDK

![Moltin](https://raw.githubusercontent.com/moltin/ios-sdk/master/moltin.png)

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Moltin.svg)](https://img.shields.io/cocoapods/v/Moltin.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Twitter](https://img.shields.io/badge/twitter-@Moltin-blue.svg?style=flat)](http://twitter.com/Moltin)

iOS/macOS/tvOS/watchOS SDK for the [Moltin](https://moltin.com) platform, written in Swift.


# Requirements

- iOS 10.0+ / macOS 10.10+ / tvOS 10.0+ / watchOS 3.0+
- Swift 4.0+

# Installation

## Cocoapods

Add the following to your `Podfile`:
```
pod 'Moltin', '~> 3.0.6'
```

Or, quickly try out our examples:
```bash
pod try Moltin
```
## Carthage

Add the following to your `Cartfile`:
```
github "Moltin/ios-sdk" ~> 3.0.6
```
## Swift Package Manager

Add the following to your `dependencies` value in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/moltin/ios-sdk.git", from: "3.0.6")
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

# Further Documentation

Find more general documentation on the [API docs](https://docs.moltin.com).

# Communication

- If you need help with the SDK or the platform, get in touch on the [forum](https://forum.moltin.com)
- If you found a bug with the SDK, open an issue on GitHub
- If you have a feature request for the SDK, open an issue.
- If you want to contribute to the SDK, submit a pull request.


# License

Moltin is available under the MIT license. See the LICENSE file for more info.
