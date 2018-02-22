// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: BrandRequest - AutoMoltinRequest

public class BrandRequest: MoltinRequest {

    private var endpoint: String = "/brands"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Brand]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Brand>

    /*
        Return all instances of type brand

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of brand by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


    /*
        Return the tree of a resource

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }
}
// MARK: CategoryRequest - AutoMoltinRequest

public class CategoryRequest: MoltinRequest {

    private var endpoint: String = "/categories"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Category]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Category>

    /*
        Return all instances of type category

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of category by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


    /*
        Return the tree of a resource

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }
}
// MARK: CollectionRequest - AutoMoltinRequest

public class CollectionRequest: MoltinRequest {

    private var endpoint: String = "/collections"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Collection]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Collection>

    /*
        Return all instances of type collection

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of collection by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


    /*
        Return the tree of a resource

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }
}
// MARK: CurrencyRequest - AutoMoltinRequest

public class CurrencyRequest: MoltinRequest {

    private var endpoint: String = "/currencies"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Currency]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Currency>

    /*
        Return all instances of type currency

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of currency by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


}
// MARK: FileRequest - AutoMoltinRequest

public class FileRequest: MoltinRequest {

    private var endpoint: String = "/files"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[File]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<File>

    /*
        Return all instances of type file

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of file by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


}
// MARK: FlowRequest - AutoMoltinRequest

public class FlowRequest: MoltinRequest {

    private var endpoint: String = "/flows"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Flow]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Flow>

    /*
        Return all instances of type flow

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of flow by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


}
// MARK: ProductRequest - AutoMoltinRequest

public class ProductRequest: MoltinRequest {

    private var endpoint: String = "/products"

    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Product]>
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Product>

    /*
        Return all instances of type product

        - parameters:
            - completionHandler: The handler to be called on success or failure
    */
    public func all(completionHandler: @escaping DefaultCollectionRequestHandler) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }


    public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) {
        super.all(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /*
        Return get an instance of product by `id`

        - parameters:
            - forID: The ID of the object
            - completionHandler: The handler to be called on success or failure
    */
    public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


    public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) {
        super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }


}
