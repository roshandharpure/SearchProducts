//
//  ApiServiceTests.swift
//  SearchProductsTests
//
//  Created by Roshan Dharpure on 30/08/23.
//

import XCTest
@testable import SearchProducts

final class ApiServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Test actual API call with actual response from cloud server.
    func testAcronymAPICall_Success() {
        // Arrange
        let apiService = ApiService()
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "Call API asynchronously.")
        
        // Act
        let param = RequestModel.productSearch(q: "phone")
        Task {
            let result = await apiService.getProducts(param: param)
            switch result {
            case .success(let model):
                if let model, let products = model.products {
                    // Assert
                    XCTAssertNotNil(products)
                    XCTAssertTrue(products.count > 0)
                    
                    // Fulfill the expectation.
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // Wait for the expectation to fulfill or time out.
        wait(for: [expectation], timeout: 10.0)
    }

    func testAcronymAPICall_Failure() {
        // Arrange
        let apiService = ApiService()
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "Call API asynchronously.")
        
        // Act
        let param = RequestModel.productSearch(q: " ")
        Task {
            let result = await apiService.getProducts(param: param)
            switch result {
            case .success(let model):
                if let model, let products = model.products {
                    // Assert
                    XCTAssertNotNil(products)
                    XCTAssertFalse(products.count > 0)
                    
                    // Fulfill the expectation.
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        // Wait for the expectation to fulfill or time out.
        wait(for: [expectation], timeout: 10.0)
    }
}

