//
//  SearchViewModel.swift
//  SearchProducts
//
//  Created by Roshan Dharpure on 30/08/23.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Variables
    var products: [Product] = []
    var apiService: ApiService
    var completion: (([Product]?, ServerError) -> ())?
    
    //MARK: - Init
    init(products: [Product] = [],
         apiService: ApiService = ApiService()
    ) {
        self.products = products
        self.apiService = apiService
    }

    //Get products list for search text
    func getProducts(searchText: String) {
        if !searchText.isEmpty {
            let param = RequestModel.productSearch(q: searchText)
            Task {
                let result = await apiService.getProducts(param: param)
                switch result {
                case .success(let model):
                    if let model {
                        self.products = model
                        
                        /// Send result to view with the help of completion block
                        if model.isEmpty {
                            completion?(model, ServerError.emptyData)
                        } else {
                            completion?(model, ServerError.none)
                        }
                    }
                case .failure(let error):
                    completion?(nil, error)
                }
            }
        }
    }
}



