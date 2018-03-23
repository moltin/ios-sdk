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


public class MyCustomBrand: Brand {
    let author: Author
    enum CodingKeys : String, CodingKey {
        case author
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomCategory: moltin.Category {
    let author: Author
    enum CodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomCollection: moltin.Collection {
    let author: Author
    enum CodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
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


class MyCustomField: Field {
    let author: Author
    private enum FieldCodingKeys : String, CodingKey { case author }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FieldCodingKeys.self)
        self.author = try container.decode(Author.self, forKey: .author)
        try super.init(from: decoder)
    }
}


class MyCustomProduct: Product {
    let author: Author
    private enum ProductCodingKeys : String, CodingKey { case author }
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
                let brands: [moltin.Brand]? = []
                XCTAssert(type(of: response.data) == type(of: brands))
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
                if let brand: Brand = MockObjectFactory.object(fromJSON: ["id": "51b56d92-ab99-4802-a2c1-be150848c629"]) {
                    XCTAssert(type(of: brand) == type(of: response))
                    XCTAssert(brand.id == response.id)
                } else {
                    XCTFail("Response returned error")
                }
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
                let brands: [MyCustomBrand]? = []
                XCTAssert(type(of: response.data) == type(of: brands))
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
                if let brand: MyCustomBrand = MockObjectFactory.object(fromJSON: ["id": "51b56d92-ab99-4802-a2c1-be150848c629", "author": ["name": "Craig"]]) {
                    XCTAssert(type(of: brand) == type(of: response))
                    XCTAssert(brand.id == response.id)
                    XCTAssert(brand.author == response.author)
                } else {
                    XCTFail("Response returned error")
                }
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
                let brands: [moltin.Brand]? = []
                XCTAssert(type(of: brands) == type(of: response.data))
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
                let brands: [MyCustomBrand]? = []
                XCTAssert(type(of: brands) == type(of: response.data))
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
                let categorys: [moltin.Category]? = []
                XCTAssert(type(of: response.data) == type(of: categorys))
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
                let category = moltin.Category(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: category) == type(of: response))
                XCTAssert(category.id == response.id)
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
                let categorys: [MyCustomCategory]? = []
                XCTAssert(type(of: response.data) == type(of: categorys))
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
                let category = MyCustomCategory(
                    withID: "51b56d92-ab99-4802-a2c1-be150848c629",
                    withAuthor: author)
                XCTAssert(type(of: category) == type(of: response))
                XCTAssert(category.id == response.id)
                XCTAssert(category.author == response.author)
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
                let categorys: [moltin.Category]? = []
                XCTAssert(type(of: categorys) == type(of: response.data))
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
                let categorys: [MyCustomCategory]? = []
                XCTAssert(type(of: categorys) == type(of: response.data))
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

    func testCollectionRequestReturnsCollections() {
        let (_, collectionRequest) = MockFactory.mockedCollectionRequest(withJSON: self.multiProductJson)
        let expectationToFulfill = expectation(description: "CollectionRequest calls the method and runs the callback closure")
        let _ = collectionRequest.all { (result) in
            switch result {
            case .success(let response):
                let collections: [moltin.Collection]? = []
                XCTAssert(type(of: response.data) == type(of: collections))
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
                let collection = moltin.Collection(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: collection) == type(of: response))
                XCTAssert(collection.id == response.id)
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
                let collections: [MyCustomCollection]? = []
                XCTAssert(type(of: response.data) == type(of: collections))
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
                let collection = MyCustomCollection(
                    withID: "51b56d92-ab99-4802-a2c1-be150848c629",
                    withAuthor: author)
                XCTAssert(type(of: collection) == type(of: response))
                XCTAssert(collection.id == response.id)
                XCTAssert(collection.author == response.author)
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
                let collections: [moltin.Collection]? = []
                XCTAssert(type(of: collections) == type(of: response.data))
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
                let collections: [MyCustomCollection]? = []
                XCTAssert(type(of: collections) == type(of: response.data))
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
                let currencys: [moltin.Currency]? = []
                XCTAssert(type(of: response.data) == type(of: currencys))
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
                let currency = moltin.Currency(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: currency) == type(of: response))
                XCTAssert(currency.id == response.id)
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
                let files: [moltin.File]? = []
                XCTAssert(type(of: response.data) == type(of: files))
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
                let file = moltin.File(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: file) == type(of: response))
                XCTAssert(file.id == response.id)
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
                let fields: [moltin.Field]? = []
                XCTAssert(type(of: response.data) == type(of: fields))
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
                let field = moltin.Field(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: field) == type(of: response))
                XCTAssert(field.id == response.id)
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
                let products: [moltin.Product]? = []
                XCTAssert(type(of: response.data) == type(of: products))
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
                let product = moltin.Product(withID: "51b56d92-ab99-4802-a2c1-be150848c629")
                XCTAssert(type(of: product) == type(of: response))
                XCTAssert(product.id == response.id)
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
                let products: [MyCustomProduct]? = []
                XCTAssert(type(of: response.data) == type(of: products))
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
                let product = MyCustomProduct(
                    withID: "51b56d92-ab99-4802-a2c1-be150848c629",
                    withAuthor: author)
                XCTAssert(type(of: product) == type(of: response))
                XCTAssert(product.id == response.id)
                XCTAssert(product.author == response.author)
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
