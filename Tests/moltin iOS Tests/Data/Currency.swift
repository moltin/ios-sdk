//
//  Currency.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockCurrencyDataFactory {

    static let currencyData = """
    {
        "data": {
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "currency",
            "code": "USD",
            "exchange_rate": 1,
            "format": "${price}",
            "decimal_point": ".",
            "thousand_separator": ",",
            "decimal_places": 2,
            "default": true,
            "enabled": true,
            "links": {
                "self": "https://api.moltin.com/currencies/7e5dd85a-f1eb-4025-8d2a-42ff3a37828f"
            },
            "meta": {
                "timestamps": {
                    "created_at": "2017-02-17T19:57:39.882Z",
                    "updated_at": "2017-09-12T10:50:09.582Z"
                }
            }
        }
    }
    """

    static let multiCurrencyData = """
    {
        "data": [{
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "type": "currency",
            "code": "USD",
            "exchange_rate": 1,
            "format": "${price}",
            "decimal_point": ".",
            "thousand_separator": ",",
            "decimal_places": 2,
            "default": true,
            "enabled": true,
            "links": {
                "self": "https://api.moltin.com/currencies/7e5dd85a-f1eb-4025-8d2a-42ff3a37828f"
            },
            "meta": {
                "timestamps": {
                    "created_at": "2017-02-17T19:57:39.882Z",
                    "updated_at": "2017-09-12T10:50:09.582Z"
                }
            }
        }]
    }
    """
}
