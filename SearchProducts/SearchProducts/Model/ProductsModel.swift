//
//  ProductsModel.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

struct Products: Codable {
    let products: [Product]?
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Double?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}

