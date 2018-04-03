//
//  Field.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockFieldDataFactory {

    static let fieldData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "field",
            "name": "Product Rating",
            "slug": "product-rating",
            "field_type": "integer",
            "validation_rules": [{
                "type": "between",
                "options": {
                    "from": 1,
                    "to": 5
                }
            }],
            "description": "Average rating as given by our users",
            "required": false,
            "unique": false,
            "default": 0,
            "enabled": true,
            "order": 1,
            "relationships": {
                "flow": {
                    "data": {
                        "type": "flow",
                        "id": "b2895a6c-8c12-4515-9e4b-a305769e7b25"
                    }
                }
            }
        }
    }
    """

    static let multiFieldData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "field",
            "name": "Product Rating",
            "slug": "product-rating",
            "field_type": "integer",
            "validation_rules": [{
                "type": "between",
                "options": {
                    "from": 1,
                    "to": 5
                }
            }],
            "description": "Average rating as given by our users",
            "required": false,
            "unique": false,
            "default": 0,
            "enabled": true,
            "order": 1,
            "relationships": {
                "flow": {
                    "data": {
                        "type": "flow",
                        "id": "b2895a6c-8c12-4515-9e4b-a305769e7b25"
                    }
                }
            }
        }]
    }
    """
}
