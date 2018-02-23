// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: BrandRequest - AutoMoltinRequest

public class BrandRequest: MoltinRequest, Request, CustomTypeRequest, TreeRequest, CustomTypeTreeRequest
{
    public var endpoint: String = "/brands"
    public typealias ContainedType = Brand
}

// MARK: CategoryRequest - AutoMoltinRequest

public class CategoryRequest: MoltinRequest, Request, CustomTypeRequest, TreeRequest, CustomTypeTreeRequest
{
    public var endpoint: String = "/categories"
    public typealias ContainedType = Category
}

// MARK: CollectionRequest - AutoMoltinRequest

public class CollectionRequest: MoltinRequest, Request, CustomTypeRequest, TreeRequest, CustomTypeTreeRequest
{
    public var endpoint: String = "/collections"
    public typealias ContainedType = Collection
}

// MARK: CurrencyRequest - AutoMoltinRequest

public class CurrencyRequest: MoltinRequest, Request
{
    public var endpoint: String = "/currencies"
    public typealias ContainedType = Currency
}

// MARK: FileRequest - AutoMoltinRequest

public class FileRequest: MoltinRequest, Request
{
    public var endpoint: String = "/files"
    public typealias ContainedType = File
}

// MARK: FlowRequest - AutoMoltinRequest

public class FlowRequest: MoltinRequest, Request
{
    public var endpoint: String = "/flows"
    public typealias ContainedType = Flow
}

// MARK: ProductRequest - AutoMoltinRequest

public class ProductRequest: MoltinRequest, Request, CustomTypeRequest
{
    public var endpoint: String = "/products"
    public typealias ContainedType = Product
}
