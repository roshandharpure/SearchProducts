//
//  ApiService+Error.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

typealias ServerError = ApiService.ResponseError

extension ApiService {
    
    /// The network response related error has been declared here.
    enum ResponseError: Error {
        case noInternet
        case networkRespose
        case requestNotFound
        case requestValidation
        case internalServer
        case unexpected(Int)
        case wrapperFailed
        case tryCatch(Error)
        case emptyData
        case none
        
        
        /// `String` represents the error in detail.
        var message: String {
            switch self {
            case .noInternet:
                return Constants.ApiErrorMessages.noInternet
            case .networkRespose:
                return Constants.ApiErrorMessages.networkRespose
            case .requestNotFound:
                return Constants.ApiErrorMessages.requestNotFound
            case .requestValidation:
                return Constants.ApiErrorMessages.requestValidation
            case .internalServer:
                return Constants.ApiErrorMessages.internalServer
            case .unexpected(let code):
                return "\(Constants.ApiErrorMessages.unexpected) - \(code)"
            case .wrapperFailed:
                return Constants.ApiErrorMessages.wrapperFailed
            case .tryCatch(let error):
                return "\(Constants.ApiErrorMessages.tryCatch) - \(error.localizedDescription)"
            case .emptyData:
                return Constants.ApiErrorMessages.emptyData
            case .none:
                return Constants.ApiErrorMessages.none
            }
        }
    }
    
}


extension URLResponse {
    
    var errorAppeared: Error? {
        if let httpsResponse = self as? HTTPURLResponse {
            let statusCode = httpsResponse.statusCode
            switch statusCode {
            case 200...299: return nil
            case 300...399: return ServerError.requestValidation
            case 400...499: return ServerError.requestNotFound
            case 500...599: return ServerError.internalServer
            default: return ServerError.unexpected(statusCode)
            }
        }
        return ServerError.wrapperFailed
    }
}
