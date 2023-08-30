//
//  SearchViewModel.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Variables
    var products: [Products] = []
    var apiService: ApiServiceProtocol
    var completion: (([Products]?, ServerError) -> ())?
    
    //MARK: - Init
    init(products: [Products] = [],
         apiService: ApiServiceProtocol = ApiService()
    ) {
        self.products = products
        self.apiService = apiService
    }

    //Get products list from search text
    func getProducts(searchText: String) {
        if !searchText.isEmpty {
            let param = RequestModel.productSearch(q: searchText)
            Task {
                let result = await apiService.getProducts(param: param)
                switch result {
                case .success(let model):
                    if let model, let products = model.products {
                        self.products = products
                        
                        /// Send result to view with the help of completion block
                        if products.isEmpty {
                            completion?(products, ServerError.emptyData)
                        } else {
                            completion?(products, ServerError.none)
                        }
                    }
                case .failure(let error):
                    completion?(nil, error)
                }
            }
        } else {
            completion?(nil, ServerError.emptyData)
        }
        
    }
}



