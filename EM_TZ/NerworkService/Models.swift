//
//  Models.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 18.03.2023.
//

import Foundation

// MARK: - Latest
struct Latest: Decodable {
    let latest: [LatestElement]
}

// MARK: - LatestElement
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
    let price: Double
    let discount: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}
