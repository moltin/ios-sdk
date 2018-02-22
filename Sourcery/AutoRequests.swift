private enum MoltinAPIEndpoints {
    /// sourcery: model = Brand, path = "/brands", hasTree
    case brand

    /// sourcery: model = Category, path = "/categories", hasTree
    case category

    /// sourcery: model = Collection, path = "/collections", hasTree
    case collection

    /// sourcery: model = Currency, path = "/currencies"
    case currency

    /// sourcery: model = File, path = "/files"
    case file

    /// sourcery: model = Flow, path = "/flows"
    case flow

    /// sourcery: model = Product, path = "/products", hasCustomType
    case product
}