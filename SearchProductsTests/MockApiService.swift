//
//  MockApiService.swift
//  SearchProductsTests
//
//  Created by Roshan Dharpure on 30/08/23.
//

import XCTest
@testable import SearchProducts

final class MockApiService: ApiServiceProtocol {

    var getProductsCalled = false
    var successResult = true
    var expectations: XCTestExpectation?
    var dummyProduct = Products(id:0, title: "iPhone 9",description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, brand: "Apple", category: "Smartphone")
    
    /// Test mock network service result with custom success and failure responses.
    func getProducts(param: Encodable) async -> Result<ProductsModel?, SearchProducts.ServerError> {
        getProductsCalled = true
        expectations?.fulfill()
        
        if successResult {
            return .success(ProductsModel(products: [dummyProduct]))
        }
        
        return .failure(ServerError.networkRespose)
    }

}
