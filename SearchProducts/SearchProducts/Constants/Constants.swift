//
//  Constants.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

enum Constants {
    //Api Urls
    enum ApiUrl {
        static let baseUrl = "https://dummyjson.com/"
        static let searchProductsUrl = baseUrl + "products/search"
    }
    
    // API errors message
    enum ApiErrorMessages {
        static let noInternet = "No Internet connectivity"
        static let networkRespose = "Server is not responding. Please try after some time"
        static let requestNotFound = "Request not found"
        static let requestValidation = "Internal request failed, check the request once again."
        static let internalServer = "Internal server error."
        static let unexpected = "Unexpected error occured, Error Code"
        static let wrapperFailed = "Invalid request."
        static let tryCatch = "Invalid response"
        static let emptyData = "No Data Found"
        static let none = "No error"
    }
    
    //Product cell label text
    enum ProductCellText {
        static let price = "Price:"
        static let brand = "Brand:"
        static let rating = "Rating:"
        static let na = "Not Available"
    }
    
}
