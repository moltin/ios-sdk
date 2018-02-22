// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: ProductRequest - AutoMoltinRequest

public class ProductRequest: MoltinRequest {

    private var path: String = "/path"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Product]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Product>

    /*
        Return all instances of type product

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(completionHandler: completionHandler)
    }
    /*
        Return get an instance of product by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(forID: id, completionHandler: completionHandler)
    }
}
// MARK: CategoryRequest - AutoMoltinRequest

public class CategoryRequest: MoltinRequest {

    private var path: String = "/category"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Category]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Category>

    /*
        Return all instances of type category

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(completionHandler: completionHandler)
    }
    /*
        Return get an instance of category by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(forID: id, completionHandler: completionHandler)
    }
}
// MARK: BrandRequest - AutoMoltinRequest

public class BrandRequest: MoltinRequest {

    private var path: String = "/brand"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Brand]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Brand>

    /*
        Return all instances of type brand

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(completionHandler: completionHandler)
    }
    /*
        Return get an instance of brand by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(forID: id, completionHandler: completionHandler)
    }
}
