//
//  Moltin.swift
//  moltin
//
//  Created by Craig Tweedy on 21/02/2018.
//

import Foundation

/// Allows access to Moltin API.
/// Create this class with a Moltin client ID and an optional configuration to access the Moltin API, and get information such as products, categories, or interact with carts.
public class Moltin {
    /**
     The config used for connecting to the Moltin API.
    */
    public var config: MoltinConfig

    /**
     Entry point to requesting information about brands
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `BrandRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with brands.
    */
    public var brand: BrandRequest {
        return BrandRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about your cart
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `CartRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with their cart, such as adding items to the cart, or checking out the cart.
     */
    public var cart: CartRequest {
        return CartRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about categories
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `CategoryRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with categories.
     */
    public var category: CategoryRequest {
        return CategoryRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about collections
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `CollectionRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with collections.
     */
    public var collection: CollectionRequest {
        return CollectionRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about currencies
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `CurrencyRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with currencies.
     */
    public var currency: CurrencyRequest {
        return CurrencyRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about files
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `FileRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with files.
     */
    public var file: FileRequest {
        return FileRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about fields
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `FieldRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with fields.
     */
    public var field: FieldRequest {
        return FieldRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about flows
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `FlowRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with flows.
     */
    public var flow: FlowRequest {
        return FlowRequest(withConfiguration: self.config)
    }

    /**
     Entry point to requesting information about products
     
     - Author:
     Craig Tweedy
     
     - returns:
     A `ProductRequest` object, inheriting from `MoltinRequest`, with the config from the `Moltin` class.
     
     This object allows the developer to interact with products.
     */
    public var product: ProductRequest {
        return ProductRequest(withConfiguration: self.config)
    }

    /**
     Allows the user to set up a instance of the `Moltin` object with a client ID and an optional configuration object
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withClientID: Your Moltin Client ID
        - withConfiguration: An optional configuration object
        - withLocale: An optional `Locale` object
     
     - returns:
     A instance of the Moltin object for users to interact with in order to call the API
     */
    public init(withClientID clientID: String, withConfiguration configuration: MoltinConfig? = nil, withLocale locale: Locale? = Locale.current) {
        let config: MoltinConfig
        if let locale = locale {
            config = MoltinConfig.default(withClientID: clientID, withLocale: locale)
        } else {
            config = MoltinConfig.default(withClientID: clientID)
        }
        self.config = configuration ?? config
    }

    /**
     Allows the user to set up a instance of the `Moltin` object with a configuration object
     
     - Author:
     Craig Tweedy
     
     - parameters:
        - withConfiguration: A configuration object. Must contain a client ID.
     
     - returns:
     A instance of the Moltin object for users to interact with in order to call the API
     */
    public init(withConfiguration configuration: MoltinConfig) {
        self.config = configuration
    }
}
