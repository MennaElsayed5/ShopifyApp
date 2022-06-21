//
//  DraftOrder.swift
//  ShopifyApp
//
//  Created by Menna on 20/06/2022.
//

import Foundation
// MARK: - CustomerEditResonse
struct DraftOrderResponseTest: Codable {
    let draftOrder: DraftOrderTest

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

// MARK: - DraftOrder
struct DraftOrderTest: Codable {
    let id: Int
    let lineItems: [LineItem]
    

    enum CodingKeys: String, CodingKey {
        case id
        case lineItems = "line_items"
        
    
    }
}
// MARK: - EmailMarketingConsent
struct EmailMarketingConsent: Codable {
    let state, optInLevel: String
    //let consentUpdatedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case state
        case optInLevel = "opt_in_level"
    }
}


// MARK: - LineItem
struct LineItem: Codable {
    
    let id, variantID, productID: Int
    let title, variantTitle, sku, vendor: String
    let quantity: Int
    


    enum CodingKeys: String, CodingKey {
        case id
        case variantID = "variant_id"
        case productID = "product_id"
        case title
        case variantTitle = "variant_title"
        case sku, vendor, quantity
        
    }
}


// MARK: - TaxLine
struct TaxLine: Codable {
    let rate: Double
    let title, price: String
}

struct EmptyObject: Codable {
    
}
struct PutOrderRequestTest: Codable {
    let draftOrder: ModifyDraftOrderRequestTest

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

struct ModifyDraftOrderRequestTest: Codable {
    let dratOrderId: Int
    let lineItems: [LineItem]
    
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case dratOrderId = "id"
    }
}
