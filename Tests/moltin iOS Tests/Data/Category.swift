//
//  Category.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockCategoryDataFactory {
    
    static let categoryData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "category",
            "name": "Clothing",
            "slug": "clothing",
            "description": "Browse our clothing line",
            "status": "live"
        }
    }
    """
    
    static let multiCategoryData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "category",
            "name": "Clothing",
            "slug": "clothing",
            "description": "Browse our clothing line",
            "status": "live"
        }]
    }
    """
    
    static let customCategoryData = """
    {
        "data": {
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "category",
            "name": "Clothing",
            "slug": "clothing",
            "description": "Browse our clothing line",
            "status": "live"
        }
    }
    """
    
    static let customMultiCategoryData = """
    {
        "data": [{
            "author": {
                "name": "Craig"
            },
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "category",
            "name": "Clothing",
            "slug": "clothing",
            "description": "Browse our clothing line",
            "status": "live"
        }]
    }
    """
}
