//
//  FlowRequest.swift
//  moltin
//
//  Created by Craig Tweedy on 20/03/2018.
//

import Foundation

public class FlowRequest: MoltinRequest {
    
    public var endpoint: String = "/flows"
    
    public typealias DefaultFlowCollectionRequestHandler = CollectionRequestHandler<[Flow]>
    public typealias DefaultFlowObjectRequestHandler = ObjectRequestHandler<Flow>
    
    public typealias DefaultEntryCollectionRequestHandler = CollectionRequestHandler<[Flow]>
    public typealias DefaultEntryObjectRequestHandler = ObjectRequestHandler<Flow>
    
    /*
     Return all instances of type flow
     
     - parameters:
     - completionHandler: The handler to be called on success or failure
     */
    public func all(completionHandler: @escaping DefaultFlowCollectionRequestHandler) -> MoltinRequest {
        return super.list(withPath: "\(self.endpoint)", completionHandler: completionHandler)
    }
    
    /*
     Return get an instance of flow by `id`
     
     - parameters:
     - forID: The ID of the object
     - completionHandler: The handler to be called on success or failure
     */
    public func get(forID id: String, completionHandler: @escaping DefaultFlowObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(id)", completionHandler: completionHandler)
    }
    
    /*
     Return all entries for the flow with the slug `slug`
     
     - parameters:
     - forSlug: The slug of the flow
     - completionHandler: The handler to be called on success or failure
     */
    public func entries(forSlug slug: String, completionHandler: @escaping DefaultEntryCollectionRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(slug)/entries", completionHandler: completionHandler)
    }
    
    /*
     Return all custom entries for the flow with the slug `slug`
     
     - parameters:
     - forSlug: The slug of the flow
     - completionHandler: The handler to be called on success or failure
     */
    public func entries<T>(forSlug slug: String, completionHandler: @escaping CollectionRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(slug)", completionHandler: completionHandler)
    }
    
    /*
     Return an entry for the flow with the slug `slug` and an ID of `id`
     
     - parameters:
     - forSlug: The slug of the flow
     - forID: The ID of the entry
     - completionHandler: The handler to be called on success or failure
     */
    public func entry(forSlug slug: String, forID id: String, completionHandler: @escaping DefaultEntryObjectRequestHandler) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(slug)/entries/\(id)", completionHandler: completionHandler)
    }
    
    /*
     Return a custom entry for the flow with the slug `slug` and an ID of `id`
     
     - parameters:
     - forSlug: The slug of the flow
     - forID: The ID of the entry
     - completionHandler: The handler to be called on success or failure
     */
    public func entry<T: Codable>(forSlug slug: String, forID id: String, completionHandler: @escaping ObjectRequestHandler<T>) -> MoltinRequest {
        return super.get(withPath: "\(self.endpoint)/\(slug)/entries/\(id)", completionHandler: completionHandler)
    }
    
    
}
