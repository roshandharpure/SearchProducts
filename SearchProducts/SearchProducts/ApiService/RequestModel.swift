//
//  RequestModel.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

enum RequestModel {
    struct productSearch: Encodable {
        let q: String
    }
}
