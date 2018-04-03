//
//  Brands.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 29/03/2018.
//

import Foundation

class MockBrandsDataFactory {
    static let brandData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "brand",
            "name": "Cool Clothing",
            "slug": "cool-clothing",
            "description": "Cool clothing make cool clothes!",
            "status": "live"
        }
    }
    """

    static let multiBrandsData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "brand",
            "name": "Cool Clothing",
            "slug": "cool-clothing",
            "description": "Cool clothing make cool clothes!",
            "status": "live"
        }]
    }
    """

    static let customBrandData = """
    {
        "data": {
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "brand",
            "name": "Cool Clothing",
            "slug": "cool-clothing",
            "description": "Cool clothing make cool clothes!",
            "status": "live"
        }
    }
    """

    static let customMultiBrandsData = """
    {
        "data": [{
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "brand",
            "name": "Cool Clothing",
            "slug": "cool-clothing",
            "description": "Cool clothing make cool clothes!",
            "status": "live"
        }]
    }
    """
}
