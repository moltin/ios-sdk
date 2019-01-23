//
//  Cart.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 03/04/2018.
//

import Foundation

class MockCartDataFactory {

    static let cartData = """
    {
        "data": {
            "id": "3333",
            "type": "cart",
            "links": {
                "self": "https://api.moltin.com/v2/carts/3333"
            },
            "meta": {
                "display_price": {
                "with_tax": {
                    "amount": 5891,
                    "currency": "USD",
                    "formatted": "$58.91"
                },
                "without_tax": {
                    "amount": 5891,
                    "currency": "USD",
                    "formatted": "$58.91"
                }
                },
                "timestamps": {
                    "created_at": "0001-01-01T00:00:00Z",
                    "updated_at": "0001-01-01T00:00:00Z"
                }
            }
        }
    }
    """

    static let cartItemsData = """
    {
        "data": [{
            "id": "abc123",
            "type": "cart_item",
            "product_id": "df32387b-6ce6-4802-9b90-1126a5c5a54f",
            "name": "Deck Shoe",
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "sku": "DS.001",
            "quantity": 1,
            "unit_price": {
                "amount": 8950,
                "currency": "GBP",
                "includes_tax": true
            },
            "value": {
                "amount": 8950,
                "currency": "GBP",
                "includes_tax": true
            },
            "links": {
                "product": "https://api.moltin.com/v2/products/df32387b-6ce6-4802-9b90-1126a5c5a54f"
            },
            "meta": {
                "display_price": {
                    "with_tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                    },
                    "without_tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        }
                    },
                    "tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        }
                    }
                },
                "timestamps": {
                    "created_at": "2017-10-25T14:08:28.569Z",
                    "updated_at": "2017-10-25T14:08:28.569Z"
                }
            }
        }]
    }
    """
    
    static let cartItemsWithTaxesData = """
    {
        "data": [{
            "id": "abc123",
            "type": "cart_item",
            "product_id": "df32387b-6ce6-4802-9b90-1126a5c5a54f",
            "name": "Deck Shoe",
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "sku": "DS.001",
            "quantity": 1,
            "unit_price": {
                "amount": 8950,
                "currency": "GBP",
                "includes_tax": true
            },
            "value": {
                "amount": 8950,
                "currency": "GBP",
                "includes_tax": true
            },
            "links": {
                "product": "https://api.moltin.com/v2/products/df32387b-6ce6-4802-9b90-1126a5c5a54f"
            },
            "relationships": {
                "taxes": {
                    "data": [{
                        "type": "tax_item",
                        "id": "0efc403c-2ec8-410a-8cef-c7939acb5e29"
                    }]
                }
            },
            "meta": {
                "display_price": {
                    "with_tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        }
                    },
                    "without_tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        }
                    },
                    "tax": {
                        "unit": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        },
                        "value": {
                            "amount": 8950,
                            "currency": "GBP",
                            "formatted": "£89.50"
                        }
                    }
                },
                "timestamps": {
                    "created_at": "2017-10-25T14:08:28.569Z",
                    "updated_at": "2017-10-25T14:08:28.569Z"
                }
            }
        }],
        "included": {
            "tax_items": [{
                "type": "tax_item",
                "id": "0efc403c-2ec8-410a-8cef-c7939acb5e29",
                "jurisdiction": "US",
                "code": "CALI-TAX",
                "name": "California Item Tax",
                "rate": 0.0775
            }]
        }
    }
    """
    
    
    static let deletedCartData = """
        {
           "data" : [
              {
                 "type" : "cart",
                 "id" : "12345"
              }
           ]
        }
    """
}
