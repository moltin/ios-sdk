// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: BrandRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Brand`
public class BrandRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/brands"

    /**
     A typealias which allows automatic casting of a collection to `[Brand]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Brand]>
    /**
     A typealias which allows automatic casting of an object to `Brand`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Brand>

    /**
     Return all instances of type `Brand`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Brand`, cast to type `T`, which must be `Codable`.
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Brand` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return all instances of type `Brand` by `id`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Brand`
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Brand`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

}
// MARK: CategoryRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Category`
public class CategoryRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/categories"

    /**
     A typealias which allows automatic casting of a collection to `[Category]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Category]>
    /**
     A typealias which allows automatic casting of an object to `Category`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Category>

    /**
     Return all instances of type `Category`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Category`, cast to type `T`, which must be `Codable`.
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Category` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return all instances of type `Category` by `id`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Category`
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Category`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

}
// MARK: CollectionRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Collection`
public class CollectionRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/collections"

    /**
     A typealias which allows automatic casting of a collection to `[Collection]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Collection]>
    /**
     A typealias which allows automatic casting of an object to `Collection`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Collection>

    /**
     Return all instances of type `Collection`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Collection`, cast to type `T`, which must be `Codable`.
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Collection` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return all instances of type `Collection` by `id`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Collection`
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

    /**
    Return the tree of `Collection`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func tree<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/tree", completionHandler: completionHandler)
    }

}
// MARK: CurrencyRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Currency`
public class CurrencyRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/currencies"

    /**
     A typealias which allows automatic casting of a collection to `[Currency]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Currency]>
    /**
     A typealias which allows automatic casting of an object to `Currency`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Currency>

    /**
     Return all instances of type `Currency`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Currency` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

}
// MARK: FileRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `File`
public class FileRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/files"

    /**
     A typealias which allows automatic casting of a collection to `[File]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[File]>
    /**
     A typealias which allows automatic casting of an object to `File`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<File>

    /**
     Return all instances of type `File`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `File` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

}
// MARK: FieldRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Field`
public class FieldRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/fields"

    /**
     A typealias which allows automatic casting of a collection to `[Field]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Field]>
    /**
     A typealias which allows automatic casting of an object to `Field`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Field>

    /**
     Return all instances of type `Field`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Field` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

}
// MARK: OrderRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Order`
public class OrderRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/orders"

    /**
     A typealias which allows automatic casting of a collection to `[Order]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Order]>
    /**
     A typealias which allows automatic casting of an object to `Order`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Order>

    /**
     Return all instances of type `Order`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Order`, cast to type `T`, which must be `Codable`.
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Order` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return all instances of type `Order` by `id`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

}
// MARK: ProductRequest - AutoMoltinRequest

/// An entry point to make API calls relating to `Product`
public class ProductRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
    */
    public var endpoint: String = "/products"

    /**
     A typealias which allows automatic casting of a collection to `[Product]`.
    */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Product]>
    /**
     A typealias which allows automatic casting of an object to `Product`.
    */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Product>

    /**
     Return all instances of type `Product`
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all(completionHandler: @escaping DefaultCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Product`, cast to type `T`, which must be `Codable`.
     - Author:
     Craig Tweedy
     - parameters:
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func all<T: Codable>(completionHandler: @escaping CollectionRequestHandler<[T]>) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Product` by `id`
     - Author:
     Craig Tweedy
     - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
     - returns:
        A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func get(forID id: String, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

    /**
    Return all instances of type `Product` by `id`, cast to type `T`, which must be `Codable`.
    - Author:
    Craig Tweedy
    - parameters:
        - forID: The ID of the object
        - completionHandler: The handler to be called on success or failure
    - returns:
        A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func get<T: Codable>(forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }

}
