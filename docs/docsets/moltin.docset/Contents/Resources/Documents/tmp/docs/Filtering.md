# Filtering

## Operations
- Filter
- Sort
- Offset / Limt
- Include

## Filter
```swift
moltin.product.filter(operator: .eq, key: "name", value: "ProductName")
```

## Sort
```swift
moltin.product.sort("order")
```
```swift
moltin.product.sort("-order")
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