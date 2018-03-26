// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest

@testable
import moltin

class Author: Codable, Equatable {
    let name: String
    init(withName name: String) {
        self.name = name
    }
    static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.name == rhs.name
    }
}


class MyCustomBrand: moltin.Brand {
    let author: Author
    enum BrandCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BrandCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomCategory: moltin.Category {
    let author: Author
    enum CategoryCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomCollection: moltin.Collection {
    let author: Author
    enum CollectionCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CollectionCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomCurrency: moltin.Currency {
    let author: Author
    enum CurrencyCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrencyCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomFile: moltin.File {
    let author: Author
    enum FileCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FileCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomField: moltin.Field {
    let author: Author
    enum FieldCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FieldCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomProduct: moltin.Product {
    let author: Author
    enum ProductCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


// MARK: BrandRequestTest - AutoMoltinRequest

class BrandRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testBrandRequestReturnsBrands() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        let _ = brandRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Brand].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testBrandRequestReturnSingleBrand() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        let _ = brandRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Brand.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testBrandRequestReturnsCustomBrands() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        let _ = brandRequest.all { (result: Result<PaginatedResponse<[MyCustomBrand]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomBrand].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testBrandRequestReturnCustomSingleBrand() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")

        let _ = brandRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomBrand>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomBrand.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }



    func testRequestReturnTree() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "BrandRequest calls the method and runs the callback closure")
        let _ = brandRequest.tree { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Brand].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }


    func testRequestReturnCustomTree() {
        let (_, brandRequest) = MockFactory.mockedBrandRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "Request calls the method and runs the callback closure")
        let _ = brandRequest.tree { (result: Result<PaginatedResponse<[MyCustomBrand]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomBrand].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: CategoryRequestTest - AutoMoltinRequest

class CategoryRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testCategoryRequestReturnsCategorys() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        let _ = categoryRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Category].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCategoryRequestReturnSingleCategory() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        let _ = categoryRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Category.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testCategoryRequestReturnsCustomCategorys() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        let _ = categoryRequest.all { (result: Result<PaginatedResponse<[MyCustomCategory]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomCategory].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCategoryRequestReturnCustomSingleCategory() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")

        let _ = categoryRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomCategory>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomCategory.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }



    func testRequestReturnTree() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "CategoryRequest calls the method and runs the callback closure")
        let _ = categoryRequest.tree { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Category].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }


    func testRequestReturnCustomTree() {
        let (_, categoryRequest) = MockFactory.mockedCategoryRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "Request calls the method and runs the callback closure")
        let _ = categoryRequest.tree { (result: Result<PaginatedResponse<[MyCustomCategory]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomCategory].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: CollectionRequestTest - AutoMoltinRequest

class CollectionRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """


    
    
    let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        let _ = collectionRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Collection].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCollectionRequestReturnSingleCollection() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        let _ = collectionRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Collection.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testCollectionRequestReturnsCustomCollections() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        let _ = collectionRequest.all { (result: Result<PaginatedResponse<[MyCustomCollection]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomCollection].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCollectionRequestReturnCustomSingleCollection() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")

        let _ = collectionRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomCollection>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomCollection.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }



    func testRequestReturnTree() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        let _ = collectionRequest.tree { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Collection].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }


    func testRequestReturnCustomTree() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.treeJson)
        let expectationToFulfill = expectation(description: "Request calls the method and runs the callback closure")
        let _ = collectionRequest.tree { (result: Result<PaginatedResponse<[MyCustomCollection]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomCollection].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: CurrencyRequestTest - AutoMoltinRequest

class CurrencyRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testCurrencyRequestReturnsCurrencys() {
        let (_, currencyRequest) = MockFactory.mockedCurrencyRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CurrencyRequest calls the method and runs the callback closure")
        let _ = currencyRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Currency].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testCurrencyRequestReturnSingleCurrency() {
        let (_, currencyRequest) = MockFactory.mockedCurrencyRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "CurrencyRequest calls the method and runs the callback closure")
        let _ = currencyRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Currency.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: FileRequestTest - AutoMoltinRequest

class FileRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testFileRequestReturnsFiles() {
        let (_, fileRequest) = MockFactory.mockedFileRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "FileRequest calls the method and runs the callback closure")
        let _ = fileRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.File].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testFileRequestReturnSingleFile() {
        let (_, fileRequest) = MockFactory.mockedFileRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "FileRequest calls the method and runs the callback closure")
        let _ = fileRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.File.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: FieldRequestTest - AutoMoltinRequest

class FieldRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testFieldRequestReturnsFields() {
        let (_, fieldRequest) = MockFactory.mockedFieldRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "FieldRequest calls the method and runs the callback closure")
        let _ = fieldRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Field].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testFieldRequestReturnSingleField() {
        let (_, fieldRequest) = MockFactory.mockedFieldRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "FieldRequest calls the method and runs the callback closure")
        let _ = fieldRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Field.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
// MARK: ProductRequestTest - AutoMoltinRequest

class ProductRequestTests: XCTestCase {
    let productJson = """
                {
                  "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                  "author": {
                    "name": "Craig"
                  }
                }
                """
    let multiProductJson = """
                {
                  "data":
                    [{
                      "id": "51b56d92-ab99-4802-a2c1-be150848c629",
                      "author": {
                        "name": "Craig"
                      }
                    }],
                    "meta": {
                    }
                }
                """

    let treeJson = """
        {
          "id": "51b56d92-ab99-4802-a2c1-be150848c629",
          "author": {
            "name": "Craig"
          }
        }
    """

    func testProductRequestReturnsProducts() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        let _ = productRequest.all { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [moltin.Product].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testProductRequestReturnSingleProduct() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        let _ = productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response) == moltin.Product.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

    func testProductRequestReturnsCustomProducts() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")
        let _ = productRequest.all { (result: Result<PaginatedResponse<[MyCustomProduct]>>) in
            switch result {
            case .success(let response):
                XCTAssert(type(of: response.data) == [MyCustomProduct].self)
                XCTAssert(response.data?.count != 0)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
            }
            expectationToFulfill.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    func testProductRequestReturnCustomSingleProduct() {
        let (_, productRequest) = MockFactory.mockedProductRequest(withJSON: self.productJson)
        let expectationToFulfill = expectation(description: "ProductRequest calls the method and runs the callback closure")

        let _ = productRequest.get(forID: "51b56d92-ab99-4802-a2c1-be150848c629") { (result: Result<MyCustomProduct>) in
            switch result {
            case .success(let response):
                let author = Author(withName: "Craig")
                XCTAssert(type(of: response) == MyCustomProduct.self)
                XCTAssert(response.id == "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(response.author == author)
                break
            case .failure(_):
                XCTFail("Response returned error")
                break
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
