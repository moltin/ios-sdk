//: Playground - noun: a place where people can play

import UIKit
import moltin
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4")

moltin.product.all { (result: Result<PaginatedResponse<[Product]>>) in
    switch result {
    case .success(let products):
        print(products)
    case .failure(let error):
        print(error)
    }
}

moltin.product.all { (result) in
    guard case .success(let products) = result else {
        // something went wrong
        if case .failure(let error) = result { print(error) }
        return
    }

    print(products)
}
