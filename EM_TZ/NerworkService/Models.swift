//
//  Models.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 18.03.2023.
//

import UIKit

// MARK: - Latest
struct Latest: Decodable {
    let latest: [LatestElement]
}

// MARK: - ProductsElement
struct LatestElement: Decodable {
    let category, name: String
    let price: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price
        case imageURL = "image_url"
    }
}

// MARK: - FlashSale
struct FlashSale: Decodable {
    let flashSale: [FlashSaleElement]

    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

// MARK: - FlashSaleElement
struct FlashSaleElement: Decodable {
    let category, name: String
    let price: Float
    let discount: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}

// MARK: - Section
struct Section {
    let sectionHeaderName: String
    var items: [ProductsElement]
}
// MARK: - ProductsElement
struct ProductsElement{
    let category: String
    let name: String
    let price: Float
    let discount: Int?
    let imageURL: String
}
