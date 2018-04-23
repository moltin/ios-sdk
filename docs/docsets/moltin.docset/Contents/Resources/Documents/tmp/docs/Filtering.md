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