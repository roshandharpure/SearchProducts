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
        static let noInternet = "Internet appears to be offline. Try again after some times"
        static let networkRespose = "Cloud server is not responding. Try again after some times"
        static let requestNotFound = "Request not found"
        static let requestValidation = "Internal request failed, check the request once again."
        static let internalServer = "Internal server error."
        static let unexpected = "Unexpected error occured, Error Code"
        static let wrapperFailed = "Optional unwrapping failed. Check the response model"
        static let tryCatch = "Error Occurred in Try-Catch block"
        static let emptyData = "Not found any data."
        static let none = "No error"
    }
    
    //Product cell label prefix
    enum ProductCellText {
        static let price = "Price:"
        static let brand = "Brand:"
        static let rating = "Rating:"
    }
    
}
