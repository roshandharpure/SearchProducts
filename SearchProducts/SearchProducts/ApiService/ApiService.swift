//
//  ApiService.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

// Define methods with model which are used to call respective APIs to get data
protocol ApiServiceProtocol {
    // Get the products with proper request.
    // - Returns: `Result` that has success response of `ProductsModel`  and failure has error results within it.
    func getProducts(param: Encodable) async -> Result<ProductsModel?, ServerError>
}


class ApiService {
    
    let urlSession: URLSession?
    
    // An enum for various HTTPMethod.
    enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
    }
    
    typealias HTTPType = ApiService.HTTPMethod
    
    // MARK: - Initializer
    init(_ session: URLSession = URLSession.shared) {
        self.urlSession = session
    }
    
    
    /// A request preparation
    /// - Parameters:
    ///   - params: `P` represents generic suits for most of the request.
    ///   - endpoint: `String` represents URL path
    ///   - type: `HTTPType` types of https request.
    /// - Returns: optional `URLRequest` can be returned with proper header, footer, body.
    func prepareRequest(params: Encodable? = nil, endpoint: String, type: HTTPType = .get) -> URLRequest? {
        guard
            let url = URL(string: endpoint)
        else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        if let params {
            switch type {
            case .post:
                request.httpBody = try? JSONEncoder().encode(params)
            case .get:
                if let params = params.asDictionary,
                   let queryComponent = prepareQueries(url, params: params) {
                    request.url = queryComponent.url
                }
            }
        }
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return request
    }
    
    /// Creates the query param based URL information.
    /// - Parameters:
    ///   - url: `URL` represents the endpoint url.
    ///   - params: `[String: Any]` request params.
    /// - Returns: Optional `URLComponents` to support query param based request.
    func prepareQueries(_ url: URL, params: [String: Any]) -> URLComponents? {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !params.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            return urlComponents
        }
        return nil
    }
    
    /// Service request and response router gateway
    /// - Parameter urlRequest: `URLRequest` represents the connectoin
    /// - Returns: `Result` that has success response and failure has error results within it.
    func callAPIServer<T: Decodable>(_ urlRequest: URLRequest) async -> Result<T?, ResponseError> {
        guard
            let urlSession
        else {
            return .failure(ResponseError.wrapperFailed)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            if let error = response.errorAppeared {
                return .failure(error)
            }
            
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        }
        catch {
            return .failure(ResponseError.tryCatch(error))
        }
    }
    
}

extension ApiService: ApiServiceProtocol {
    // MARK: - Custom methods.
    /// get products API call
    func getProducts(param: Encodable) async -> Result<ProductsModel?, ServerError> {
        guard
            let request = prepareRequest(params: param, endpoint: Constants.ApiUrl.searchProductsUrl)
        else {
            return .failure(ResponseError.wrapperFailed)
        }
        return await callAPIServer(request)
    }
}

