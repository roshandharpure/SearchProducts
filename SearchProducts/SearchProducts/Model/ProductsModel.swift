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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        products = try values.decodeIfPresent([Products].self , forKey: .products )
        total    = try values.decodeIfPresent(Int.self        , forKey: .total    )
        skip     = try values.decodeIfPresent(Int.self        , forKey: .skip     )
        limit    = try values.decodeIfPresent(Int.self        , forKey: .limit    )
        
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id                 = try values.decodeIfPresent(Int.self      , forKey: .id                 )
        title              = try values.decodeIfPresent(String.self   , forKey: .title              )
        description        = try values.decodeIfPresent(String.self   , forKey: .description        )
        price              = try values.decodeIfPresent(Int.self      , forKey: .price              )
        discountPercentage = try values.decodeIfPresent(Double.self   , forKey: .discountPercentage )
        rating             = try values.decodeIfPresent(Double.self   , forKey: .rating             )
        stock              = try values.decodeIfPresent(Int.self      , forKey: .stock              )
        brand              = try values.decodeIfPresent(String.self   , forKey: .brand              )
        category           = try values.decodeIfPresent(String.self   , forKey: .category           )
        thumbnail          = try values.decodeIfPresent(String.self   , forKey: .thumbnail          )
        images             = try values.decodeIfPresent([String].self , forKey: .images             )
        
    }
    
}

