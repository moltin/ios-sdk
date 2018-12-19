//
//  PaymentMethodTests.swift
//  moltin iOS Tests
//
//  Created by Craig Tweedy on 16/12/2018.
//

import XCTest
import moltin

class PaymentMethodTests: XCTestCase {
    
    func testStripeTokenPaymentMethodToken() {
        let method = StripeToken(withStripeToken: "12345")
        let paymentData = method.paymentData
        XCTAssertEqual((paymentData["payment"] as? String), "12345")
    }

    func testStripeTokenPaymentMethodEmptyOptions() {
        let method = StripeToken(withStripeToken: "12345")
        let paymentData = method.paymentData
        XCTAssertNil(paymentData["options"])
    }
    
    func testStripeTokenPaymentMethodWithOptions() {
        let method = StripeToken(withStripeToken: "12345", withOptions: [
            "destination": "6789"
        ])
        let paymentData = method.paymentData
        XCTAssertNotNil(paymentData["options"])
    }

}
