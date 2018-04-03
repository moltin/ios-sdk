//
//  Products.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 29/03/2018.
//

import Foundation

class MockProductDataFactory {
    static let productData = """
    {
        "data": {
            "type": "product",
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "name": "Deck Shoe",
            "slug": "deck-shoe",
            "sku": "deck-shoe-001",
            "manage_stock": true,
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "price": [
              {
                "amount": 5891,
                "currency": "USD",
                "includes_tax": true
              }
            ],
            "status": "live",
            "commodity_type": "physical",
            "meta": {
              "timestamps": {
                "created_at": "2017-08-25T09:36:14+00:00",
                "updated_at": "2017-08-25T09:36:14+00:00"
              },
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
              "stock": {
                "level": 31,
                "availability": "in-stock"
              },
              "variation_matrix": []
            },
            "relationships": {
                "categories": {
                    "data": [
                        {
                            "type": "category",
                            "id": "8550c943-85c2-4239-a8a4-bfa255a38f08"
                        }
                    ]
                },
                "brands": {
                    "data": [
                        {
                            "type": "brand",
                            "id": "c2c16959-5dfa-4ce8-a122-28523c04c0a2"
                        }
                    ]
                },
                "collections": {
                    "data": [
                        {
                            "type": "collection",
                            "id": "ced85f3a-f1d2-47b5-ada5-bcbc43eb59eb"
                        }
                    ]
                },
                "files": {
                    "data": [
                        {
                            "type": "file",
                            "id": "f1a384bc-e77b-4fe7-9cdd-ec82095f2769"
                        }
                    ]
                },
                "main_image": {
                    "data": {
                        "type": "main_image",
                        "id": "54ef64a7-8a43-4398-acf2-66aa3c038136"
                    }
                }
            }
        }
    }
    """

    static let multiProductData = """
    {
        "data": [{
            "type": "product",
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "name": "Deck Shoe",
            "slug": "deck-shoe",
            "sku": "deck-shoe-001",
            "manage_stock": true,
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "price": [
              {
                "amount": 5891,
                "currency": "USD",
                "includes_tax": true
              }
            ],
            "status": "live",
            "commodity_type": "physical",
            "meta": {
              "timestamps": {
                "created_at": "2017-08-25T09:36:14+00:00",
                "updated_at": "2017-08-25T09:36:14+00:00"
              },
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
              "stock": {
                "level": 31,
                "availability": "in-stock"
              },
              "variation_matrix": []
            },
            "relationships": {
                "categories": {
                    "data": [
                        {
                            "type": "category",
                            "id": "8550c943-85c2-4239-a8a4-bfa255a38f08"
                        }
                    ]
                },
                "brands": {
                    "data": [
                        {
                            "type": "brand",
                            "id": "c2c16959-5dfa-4ce8-a122-28523c04c0a2"
                        }
                    ]
                },
                "collections": {
                    "data": [
                        {
                            "type": "collection",
                            "id": "ced85f3a-f1d2-47b5-ada5-bcbc43eb59eb"
                        }
                    ]
                },
                "files": {
                    "data": [
                        {
                            "type": "file",
                            "id": "f1a384bc-e77b-4fe7-9cdd-ec82095f2769"
                        }
                    ]
                },
                "main_image": {
                    "data": {
                        "type": "main_image",
                        "id": "54ef64a7-8a43-4398-acf2-66aa3c038136"
                    }
                }
            }
        }]
    }
    """

    static let customProductData = """
    {
        "data": {
            "author": {
                "name": "Craig"
            },
            "type": "product",
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "name": "Deck Shoe",
            "slug": "deck-shoe",
            "sku": "deck-shoe-001",
            "manage_stock": true,
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "price": [
              {
                "amount": 5891,
                "currency": "USD",
                "includes_tax": true
              }
            ],
            "status": "live",
            "commodity_type": "physical",
            "meta": {
              "timestamps": {
                "created_at": "2017-08-25T09:36:14+00:00",
                "updated_at": "2017-08-25T09:36:14+00:00"
              },
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
              "stock": {
                "level": 31,
                "availability": "in-stock"
              },
              "variation_matrix": []
            },
            "relationships": {
                "categories": {
                    "data": [
                        {
                            "type": "category",
                            "id": "8550c943-85c2-4239-a8a4-bfa255a38f08"
                        }
                    ]
                },
                "brands": {
                    "data": [
                        {
                            "type": "brand",
                            "id": "c2c16959-5dfa-4ce8-a122-28523c04c0a2"
                        }
                    ]
                },
                "collections": {
                    "data": [
                        {
                            "type": "collection",
                            "id": "ced85f3a-f1d2-47b5-ada5-bcbc43eb59eb"
                        }
                    ]
                },
                "files": {
                    "data": [
                        {
                            "type": "file",
                            "id": "f1a384bc-e77b-4fe7-9cdd-ec82095f2769"
                        }
                    ]
                },
                "main_image": {
                    "data": {
                        "type": "main_image",
                        "id": "54ef64a7-8a43-4398-acf2-66aa3c038136"
                    }
                }
            }
        }
    }
    """

    static let customMultiProductData = """
    {
        "data": [{
            "author": {
                "name": "Craig"
            },
            "type": "product",
            "id": "51b56d92-ab99-4802-a2c1-be150848c629",
            "name": "Deck Shoe",
            "slug": "deck-shoe",
            "sku": "deck-shoe-001",
            "manage_stock": true,
            "description": "Modern boat shoes were invented in 1935 by American Paul A. Sperry of New Haven, Connecticut after noticing his dog's ability to run easily over ice without slipping. Using a knife, he cut siping into his shoes' soles, inspiring a shoe perfect for boating and a company called Sperry Top-Sider.",
            "price": [
              {
                "amount": 5891,
                "currency": "USD",
                "includes_tax": true
              }
            ],
            "status": "live",
            "commodity_type": "physical",
            "meta": {
              "timestamps": {
                "created_at": "2017-08-25T09:36:14+00:00",
                "updated_at": "2017-08-25T09:36:14+00:00"
              },
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
              "stock": {
                "level": 31,
                "availability": "in-stock"
              },
              "variation_matrix": []
            },
            "relationships": {
                "categories": {
                    "data": [
                        {
                            "type": "category",
                            "id": "8550c943-85c2-4239-a8a4-bfa255a38f08"
                        }
                    ]
                },
                "brands": {
                    "data": [
                        {
                            "type": "brand",
                            "id": "c2c16959-5dfa-4ce8-a122-28523c04c0a2"
                        }
                    ]
                },
                "collections": {
                    "data": [
                        {
                            "type": "collection",
                            "id": "ced85f3a-f1d2-47b5-ada5-bcbc43eb59eb"
                        }
                    ]
                },
                "files": {
                    "data": [
                        {
                            "type": "file",
                            "id": "f1a384bc-e77b-4fe7-9cdd-ec82095f2769"
                        }
                    ]
                },
                "main_image": {
                    "data": {
                        "type": "main_image",
                        "id": "54ef64a7-8a43-4398-acf2-66aa3c038136"
                    }
                }
            }
        }]
    }
    """
}
