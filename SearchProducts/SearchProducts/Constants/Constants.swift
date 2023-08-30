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
    
    /// API errors message
    enum ApiErrorMessages {
        static let noInternet = "No Internet connectivity"
        static let networkRespose = "Server is not responding. Please try after some time"
        static let requestNotFound = "Request not found"
        static let requestValidation = "Internal request failed, check the request once again."
        static let internalServer = "Internal server error."
        static let unexpected = "Unexpected error occured, Error Code"
        static let wrapperFailed = "Optional unwrapping failed. Check the response model"
        static let tryCatch = "Error Occurred in Try-Catch block"
        static let emptyData = "Data Not Found"
        static let none = "No error"
    }
    
    //Product cell label prefix
    enum ProductCellText {
        static let price = "Price:"
        static let brand = "Brand:"
        static let rating = "Rating:"
        static let na = "Not Available"
    }
    
}
