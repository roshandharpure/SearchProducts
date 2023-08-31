//
//  ProductsModel.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

struct ProductsModel: Codable {
    var products : [Products]? = []
    var total    : Int?        = nil
    var skip     : Int?        = nil
    var limit    : Int?        = nil
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case total    = "total"
        case skip     = "skip"
        case limit    = "limit"
    }
    
    init(products:[Products]? = nil,
         total: Int? = nil,
         skip: Int? = nil,
         limit: Int? = nil)
    {
        self.products = products
        self.total = total
        self.skip = skip
        self.limit = limit
    }
   
}

struct Products: Codable {
    var id                 : Int?      = nil
    var title              : String?   = nil
    var description        : String?   = nil
    var price              : Int?      = nil
    var discountPercentage : Double?   = nil
    var rating             : Double?   = nil
    var stock              : Int?      = nil
    var brand              : String?   = nil
    var category           : String?   = nil
    var thumbnail          : String?   = nil
    var images             : [String]? = []
    
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case title              = "title"
        case description        = "description"
        case price              = "price"
        case discountPercentage = "discountPercentage"
        case rating             = "rating"
        case stock              = "stock"
        case brand              = "brand"
        case category           = "category"
        case thumbnail          = "thumbnail"
        case images             = "images"
    }
    
    init(id: Int? = nil,
         title: String? = nil,
         description: String? = nil,
         price: Int? = nil,
         discountPercentage: Double? = nil,
         rating: Double? = nil,
         stock: Int? = nil,
         brand: String? = nil,
         category: String? = nil,
         thumbnail: String? = nil,
         images: [String]? = nil)
    {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}

