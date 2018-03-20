//
//  CartTests.swift
//  moltin iOS
//
//  Created by Craig Tweedy on 26/02/2018.
//

import XCTest

@testable
import moltin

class CartTests: XCTestCase {
    
    let cartJSON = """
        {
            "id": "abc",
            "items": [{
                "id": "12345",
                "quantity": 5
            }]
        }
    """
    
    let cartItemJSON = """
        {
            "id": "12345",
            "quantity": 5
        }
    """
    
    let cartJSONWithItems = """
        {
            "id": "abc",
            "items": [{
                "id": "12345",
                "quantity": 5
            }]
        }
    """
    
    let cartItemsJSON = """
    {
        "data":
        [{
            "id": "12345",
            "quantity": 5
        }],
        "meta": {}
    }
    """
    
    
    
    func testGettingANewCart() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: self.cartJSON)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let _ = request.get(forID: "abc") { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(cart.id == "abc")
            case .failure(_):
                XCTFail()
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
        
    }
    
    func testGettingCartItems() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: self.cartItemsJSON)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let _ = request.items(forCartID: "abc") { (result) in
            switch result {
            case .success(let cartItems):
                XCTAssert(cartItems.data?[0].id == "12345")
            case .failure(_):
                XCTFail()
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testAddingAProductToCart() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: self.cartJSONWithItems)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let cart = Cart(withID: "12345")
        let product = Product(withID: "12345")
        let _ = request.addProduct(product, ofQuantity: 5, toCart: cart.id) { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(cart.items.count == 1)
                XCTAssert(cart.items[0].quantity == 5)
            case .failure(_):
                XCTFail()
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testBuildingACartItem() {
        let request = CartRequest(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        let item = request.buildCartItem(withID: "12345", ofQuantity: 5)
        XCTAssert(item["type"] as? String == "cart_item")
        XCTAssert(item["id"] as? String == "12345")
        XCTAssert(item["quantity"] as? Int == 5)
    }
    
    func testAddingACustomItem() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: self.cartJSONWithItems)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let cart = Cart(withID: "12345")
        let customItem = CustomCartItem(withSKU: "12345")
        let _ = request.addCustomItem(customItem, toCart: cart.id) { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(cart.items.count == 1)
                XCTAssert(cart.items[0].quantity == 5)
            case .failure(_):
                XCTFail()
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testBuildingACustomItem() {
        let request = CartRequest(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        let customItem = CustomCartItem(withSKU: "12345")
        let item = request.buildCustomItem(withCustomItem: customItem)
        XCTAssert(item["type"] as? String == "custom_item")
        XCTAssert(item["sku"] as? String == "12345")
    }
    
    func testAddingAPromotion() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: self.cartItemJSON)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let cart = Cart(withID: "12345")
        let _ = request.addPromotion("12345", toCart: cart.id) { (result) in
            switch result {
            case .success(let cartItem):
                XCTAssert(cartItem.id == "12345")
            case .failure(_):
                XCTFail()
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testBuildingAPromotionItem() {
        let request = CartRequest(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        let item = request.buildCartItem(withID: "12345", ofType: .promotionItem)
        XCTAssert(item["type"] as? String == "promotion_item")
        XCTAssert(item["code"] as? String == "12345")
    }
    
    func testRemovingAnItemFromCart() {
        
    }
    
    func testUpdatingAnItemInCart() {
        
    }
    
    func testCheckingOutCart() {
        
    }
    
    func testBuildingCheckoutCartDataWithoutShippingAddressWorks() {
        let request = CartRequest(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        let customer = Customer(withID: "12345")
        let billingAddress = Address(withAddressLine1: "7 Patterdale Terrace")
        let item = request.buildCartCheckoutData(withCustomer: customer, withBillingAddress: billingAddress, withShippingAddress: nil)
        let customerDetails = item["customer"] as? [String: Any] ?? [:]
        let shippingDetails = item["shipping_address"] as? [String: Any] ?? [:]
        let billingDetails = item["billing_address"] as? [String: Any] ?? [:]
        XCTAssert(customerDetails["id"] as? String == "12345")
        XCTAssert(shippingDetails["line_1"] as? String == "7 Patterdale Terrace")
        XCTAssert(billingDetails["line_1"] as? String == "7 Patterdale Terrace")
        
    }
    
    func testBuildingCheckoutCartDataWithShippingAddressWorks() {
        let request = CartRequest(withConfiguration: MoltinConfig.default(withClientID: "12345"))
        let customer = Customer(withID: "12345")
        let billingAddress = Address(withAddressLine1: "7 Patterdale Terrace")
        let shippingAddress = Address(withAddressLine1: "8 Patterdale Terrace")
        let item = request.buildCartCheckoutData(withCustomer: customer, withBillingAddress: billingAddress, withShippingAddress: shippingAddress)
        let customerDetails = item["customer"] as? [String: Any] ?? [:]
        let shippingDetails = item["shipping_address"] as? [String: Any] ?? [:]
        let billingDetails = item["billing_address"] as? [String: Any] ?? [:]
        XCTAssert(customerDetails["id"] as? String == "12345")
        XCTAssert(shippingDetails["line_1"] as? String == "8 Patterdale Terrace")
        XCTAssert(billingDetails["line_1"] as? String == "7 Patterdale Terrace")
        
    }
    
    func testDeletingCart() {
        
    }
}
