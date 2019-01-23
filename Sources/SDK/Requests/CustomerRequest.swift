//
//  CustomerRequest.swift
//  moltin
//
//  Created by Craig Tweedy on 25/04/2018.
//

import Foundation

/// An entry point to make API calls relating to `Customer` and related items
public class CustomerRequest: MoltinRequest {

    /**
     The API endpoint for this resource.
     */
    public var endpoint: String = "/customers"

    /**
     A typealias which allows automatic casting of a collection to `[Customer]`.
     */
    public typealias DefaultCollectionRequestHandler = CollectionRequestHandler<[Customer]>
    /**
     A typealias which allows automatic casting of an object to `Customer`.
     */
    public typealias DefaultObjectRequestHandler = ObjectRequestHandler<Customer>

    /**
     A typealias which allows automatic casting of a collection to `[Address]`.
     */
    public typealias DefaultAddressCollectionRequestHandler = CollectionRequestHandler<[Address]>
    /**
     A typealias which allows automatic casting of an object to `Address`.
     */
    public typealias DefaultAddressObjectRequestHandler = ObjectRequestHandler<Address>

    /**
     Get a token for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - withEmail: The email for the customer
     - withPassword: The password for the customer
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func getToken(withEmail email: String,
                                            withPassword password: String,
                                            completionHandler: @escaping ObjectRequestHandler<CustomerToken>) -> MoltinRequest {
        let data = [
            "type": "token",
            "email": email,
            "password": password
        ]
        return super.post(withPath: "\(self.endpoint)/tokens", withData: data, completionHandler: completionHandler)
    }

    /**
     Return all instances of type `Customer`
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
     Return all instances of type `Customer` by `id`
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
     Update a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - customer: The `UpdateCustomer` data object to update this `Customer` with.
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
    */
    @discardableResult public func update(_ customer: UpdateCustomer, completionHandler: @escaping DefaultObjectRequestHandler) -> MoltinRequest {
        return super.put(withPath: "\(self.endpoint)/\(customer.id ?? "")", withData: customer.toDictionary(), completionHandler: completionHandler)
    }

    /**
     Return all instances of `Address` for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - forCustomer: The customer ID
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func addresses(forCustomer customer: String, completionHandler: @escaping DefaultAddressCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)/\(customer)/addresses", completionHandler: completionHandler)
    }

    /**
     Get a specific `Address` for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - withID: The `Address` ID
     - forCustomer: The `Customer` ID
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func getAddress(withID id: String, forCustomer customer: String, completionHandler: @escaping DefaultAddressObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(customer)/addresses/\(id)", completionHandler: completionHandler)
    }

    /**
     Create an `Address` for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - address: The `Address` object to create
     - forCustomer: The `Customer` ID to associate this address with
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     */
    @discardableResult public func createAddress(_ address: Address,
                                                 forCustomer customer: String,
                                                 completionHandler: @escaping DefaultAddressObjectRequestHandler) -> MoltinRequest {
        return super.post(withPath: "\(self.endpoint)/\(customer)/addresses", withData: address.toDictionary(), completionHandler: completionHandler)
    }

    /**
     Update an `Address` for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - address: The `Address` object to create
     - forCustomer: The `Customer` ID to associate this address with
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     
     Ensure the `Address` contains the ID for the `Address` that you wish to create, and then fill in any variables you want to update in the request.
     */
    @discardableResult public func updateAddress(_ address: Address,
                                                 forCustomer customer: String,
                                                 completionHandler: @escaping DefaultAddressObjectRequestHandler) -> MoltinRequest {
        return super.put(withPath: "\(self.endpoint)/\(customer)/addresses/\(address.id ?? "")", withData: address.toDictionary(), completionHandler: completionHandler)
    }

    /**
     Delete an `Address` for a `Customer`
     - Author:
     Craig Tweedy
     - parameters:
     - withID: The address ID
     - forCustomer: The `Customer` ID to associate this address with
     - completionHandler: The handler to be called on success or failure
     - returns:
     A instance of `MoltinRequest` which encapsulates the request.
     
     Ensure the `Address` contains the ID for the `Address` that you wish to create, and then fill in any variables you want to update in the request.
     */
    @discardableResult public func deleteAddress(withID id: String,
                                                 forCustomer customer: String,
                                                 completionHandler: @escaping DefaultAddressObjectRequestHandler) -> MoltinRequest {
        return super.delete(withPath: "\(self.endpoint)/\(customer)/addresses/\(id)", completionHandler: completionHandler)
    }
}
