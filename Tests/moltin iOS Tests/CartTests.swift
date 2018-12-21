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

    func testGettingANewCart() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartData)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")

        _ = request.get(forID: "3333") { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(cart.id == "3333")
                XCTAssert(type(of: cart) == moltin.Cart.self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartItemsData)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")

        _ = request.items(forCartID: "3333") { (result) in
            switch result {
            case .success(let cartItems):
                XCTAssert(cartItems.data?[0].id == "abc123")
                XCTAssert(type(of: cartItems.data) == Optional<[moltin.CartItem]>.self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectationToFulfill.fulfill()
        }

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testGettingCartItemsWithTaxes() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartItemsWithTaxesData)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        _ = request.items(forCartID: "3333") { (result) in
            switch result {
            case .success(let cartItems):
                XCTAssert(cartItems.data?[0].id == "abc123")
                XCTAssert(type(of: cartItems.data) == Optional<[moltin.CartItem]>.self)
                XCTAssert(cartItems.data?[0].relationships != nil)
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartItemsData)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")

        let cartID = "3333"
        let productID = "12345"
        _ = request.addProduct(withID: productID, ofQuantity: 5, toCart: cartID) { (result) in
            switch result {
            case .success(let cartItems):
                XCTAssert(cartItems[0].id == "abc123")
                XCTAssert(type(of: cartItems) == [moltin.CartItem].self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartItemsData)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")

        let cartID: String = "3333"
        let customItem = CustomCartItem(withSKU: "12345")
        _ = request.addCustomItem(customItem, toCart: cartID) { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(type(of: cart) == [moltin.CartItem].self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.cartItemsData)

        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")

        let cartID: String = "3333"
        _ = request.addPromotion("12345", toCart: cartID) { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(type(of: cart) == [moltin.CartItem].self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
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
        let billingAddress = Address(withFirstName: "Craig", withLastName: "Tweedy")
        billingAddress.line1 = "7 Patterdale Terrace"
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
        let billingAddress = Address(withFirstName: "Craig", withLastName: "Tweedy")
        billingAddress.line1 = "7 Patterdale Terrace"
        let shippingAddress = Address(withFirstName: "Craig", withLastName: "Tweedy")
        shippingAddress.line1 = "8 Patterdale Terrace"
        let item = request.buildCartCheckoutData(withCustomer: customer, withBillingAddress: billingAddress, withShippingAddress: shippingAddress)
        let customerDetails = item["customer"] as? [String: Any] ?? [:]
        let shippingDetails = item["shipping_address"] as? [String: Any] ?? [:]
        let billingDetails = item["billing_address"] as? [String: Any] ?? [:]
        XCTAssert(customerDetails["id"] as? String == "12345")
        XCTAssert(shippingDetails["line_1"] as? String == "8 Patterdale Terrace")
        XCTAssert(billingDetails["line_1"] as? String == "7 Patterdale Terrace")

    }

    func testDeletingCart() {
        let (_, request) = MockFactory.mockedCartRequest(withJSON: MockCartDataFactory.deletedCartData)
        
        let expectationToFulfill = expectation(description: "CartRequest calls the method and runs the callback closure")
        
        let cartID: String = "3333"
        _ = request.deleteCart(cartID) { (result) in
            switch result {
            case .success(let cart):
                XCTAssert(type(of: cart) == [moltin.Cart].self)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectationToFulfill.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
