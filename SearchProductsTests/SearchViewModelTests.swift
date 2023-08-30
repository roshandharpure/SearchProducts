//
//  SearchViewModelTests.swift
//  SearchProductsTests
//
//  Created by Roshan Dharpure on 30/08/23.
//

import XCTest
@testable import SearchProducts

final class SearchViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// For success response
    func testProductData_Success() {
        // Arrange
        let mockApiService = MockApiService()
        let searchViewModel = SearchViewModel(apiService: mockApiService)
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "SearchViewModel test success")
        mockApiService.expectations = expectation
        
        // Act
        searchViewModel.getProducts(searchText: "phone")
        wait(for: [expectation], timeout: 10.0)
        
        // Assert
        XCTAssertTrue(mockApiService.getProductsCalled)
        XCTAssertNotNil(searchViewModel.products)
        XCTAssertTrue(searchViewModel.products.count > 0)
    }
    
    /// For failure response
    func testProductData_Failure() {
        // Arrange
        let mockApiService = MockApiService()
        mockApiService.successResult = false
        let searchViewModel = SearchViewModel(apiService: mockApiService)
        
        // Create an expectation for an asynchronous task.
        let expectation = XCTestExpectation(description: "SearchViewModel test failure")
        mockApiService.expectations = expectation
        
        // Act
        searchViewModel.getProducts(searchText: " ")
        wait(for: [expectation], timeout: 10.0)
        
        // Assert
        XCTAssertTrue(mockApiService.getProductsCalled)
        XCTAssertTrue(searchViewModel.products.isEmpty)
    }

}
