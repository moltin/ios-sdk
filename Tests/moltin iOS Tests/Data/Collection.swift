//
//  Collection.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockCollectionDataFactory {

    static let collectionData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "collection",
            "name": "Winter Season",
            "slug": "winter-season",
            "description": "Our Winter Season is now live!",
            "status": "live"
        }
    }
    """

    static let multiCollectionData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "collection",
            "name": "Winter Season",
            "slug": "winter-season",
            "description": "Our Winter Season is now live!",
            "status": "live"
        }]
    }
    """

    static let customCollectionData = """
    {
        "data": {
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "collection",
            "name": "Winter Season",
            "slug": "winter-season",
            "description": "Our Winter Season is now live!",
            "status": "live"
        }
    }
    """

    static let customMultiCollectionData = """
    {
        "data": [{
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "collection",
            "name": "Winter Season",
            "slug": "winter-season",
            "description": "Our Winter Season is now live!",
            "status": "live"
        }]
    }
    """
}
