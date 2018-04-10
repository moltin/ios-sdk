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