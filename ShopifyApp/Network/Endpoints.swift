//
//  Endpoints.swift
//  ShopifyApp
//
//  Created by Peter Samir on 25/05/2022.
//

import Foundation


enum Endpoints {
    case allProducts
    case HomeCategoryProducts
    case MenCategoryProduct
    case WomenCategoryProduct
    case KidsCategoryProduct
    case SaleCategoryProduct
    case HomeWithProductType(id:categoryID)
    case ProductDetails(id:String)
    case Smart_collections
    case CollectionID(id:String)
    case Customers 
    case TshirtType(id:String)
    case ShoesType(id:String)
    case AccecoriesType(id:String)
    case CustomerOrders(id:String)
    case AddressByID(id:String)
    case getDiscountCode(priceRule: String)
    
    var path:String{
        switch self {
        case .SaleCategoryProduct:
            return "collections/395963695362/products.json"
        case .HomeCategoryProducts:
            return "products.json"
        case .MenCategoryProduct:
            return "collections/395963597058/products.json"
        case .WomenCategoryProduct:
            return "collections/395965432066/products.json"
        case .KidsCategoryProduct:
            return "collections/395964940546/products.json"
        case .ProductDetails(id: let productId):
            return "products/\(productId).json"
        case .Customers:
            return "customers.json"
        case .allProducts:
            return "products.json"
        case .Smart_collections:
            return "smart_collections.json"
        case .CollectionID(id: let collectionId):
            return "products.json?collection_id=\(collectionId)"
        case .TshirtType(id: let categoryID):
            return "products.json?collection_id=\(categoryID)&product_type=T-SHIRTS"
        case .ShoesType(id: let categoryID):
            return "products.json?collection_id=\(categoryID)&product_type=shoes"
        case .AccecoriesType(id: let categoryID):
            return "products.json?collection_id=\(categoryID)&product_type=ACCESSORIES"
        case .HomeWithProductType(id: let categoryID):
            return "products.json?product_type=\(categoryID)"
        case .CustomerOrders(id: let orderId):
            return "orders.json?customer_id=\(orderId)"
        case .AddressByID(id: let id):
            return "customers/\(id)/addresses.json"
        case .getDiscountCode(priceRule: _): //1173393670402
            return "price_rules/1173393670402/discount_codes.json"
        }
    }
}

enum categoryID {
    case MEN
    case WOMEN
    case KIDS
    case SALE
    case Home(type:String)
    
    var ID:String{
        switch self {
        case .MEN:
            return "395963597058"
        case .WOMEN:
            return "395965432066"
        case .KIDS:
            return "395964940546"
        case .SALE:
            return "395963695362"
        case .Home(type: let type):
            return "customers/\(type).json"
        }
    }
}
//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/products.json?collection_id=395728126181‬&product_type=T-SHIRTS

//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/products.json?collection_id=395728126181&product_type=shoes

//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/customers/6463260754149/.json


// print
//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/products.json?collection_id=395728126181‬&product_type=shoes

//sha8al
//https://c48655414af1ada2cd256a6b5ee391be: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@mobile-ismailia.myshopify.com/admin/api/2022-04/products.json?collection_id=269278838836

//https://54e7ce1d28a9d3b395830ea17be70ae1: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@mad-ism2022.myshopify.com/admin/api/2022-04/products.json?collection_id=395963597058
