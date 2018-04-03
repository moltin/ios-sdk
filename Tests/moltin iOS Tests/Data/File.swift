//
//  File.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockFileDataFactory {
    
    static let fileData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "file",
            "link": {
                "href": "https://s3-eu-west-1.amazonaws.com/bkt-api-moltin-com/2a85964e-cb3d-482a-ab02-0f0e47ab5662/273d3ff0-5034-4986-8786-0ff97450745.jpg"
            },
            "file_name": "image.jpg",
            "mime_type": "image/jpeg",
            "file_size": 20953,
            "public": true,
            "meta": {
                "dimensions": {
                    "width": 1600,
                    "height": 800
                },
                "timestamps": {
                    "created_at": "2017-08-14T10:47:45.191Z"
                }
            },
            "links": {
                "current": "https://api.moltin.com/v2/files/272d3ff0-5034-4986-8786-0ff97450745d"
            }
        }
    }
    """
    
    static let multiFileData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "file",
            "link": {
                "href": "https://s3-eu-west-1.amazonaws.com/bkt-api-moltin-com/2a85964e-cb3d-482a-ab02-0f0e47ab5662/273d3ff0-5034-4986-8786-0ff97450745.jpg"
            },
            "file_name": "image.jpg",
            "mime_type": "image/jpeg",
            "file_size": 20953,
            "public": true,
            "meta": {
                "dimensions": {
                    "width": 1600,
                    "height": 800
                },
                "timestamps": {
                    "created_at": "2017-08-14T10:47:45.191Z"
                }
            },
            "links": {
                "current": "https://api.moltin.com/v2/files/272d3ff0-5034-4986-8786-0ff97450745d"
            }
        }]
    }
    """
}
