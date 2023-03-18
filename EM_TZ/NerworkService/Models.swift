//
//  Models.swift
//  EM_TZ
//
//  Created by Pavel Krivtsov on 18.03.2023.
//

import Foundation

// MARK: - Latest
struct Latest: Codable {
    let latest: [LatestElement]
}

// MARK: - LatestElement
struct LatestElement: Codable {
    let category, name: String
    let price: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price
        case imageURL = "image_url"
    }
}
