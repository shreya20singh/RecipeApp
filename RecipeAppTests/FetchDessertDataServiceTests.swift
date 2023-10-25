//
//  FetchDessertDataServiceTests.swift
//  RecipeAppTests
//
//  Created by Shreya Singh on 10/25/23.
//

import XCTest
@testable import RecipeApp

class FetchDessertDataServiceTests: XCTestCase {
    var sut: FetchDessertDataService!

    override func setUp() {
        super.setUp()
        sut = FetchDessertDataService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchDataSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetching dessert data")

        // When
        Task {
            do {
                let meals = try await sut.fetchData()
                XCTAssertFalse(meals.isEmpty)
                expectation.fulfill()
            } catch {
                XCTFail("Failed to fetch dessert data: \(error)")
            }
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testFetchDataFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetching dessert data")

        // Inject an invalid URL to simulate a failure
        sut.url = "https://invalid-url-that-does-not-exist.com"

        // When
        Task {
            do {
                let _ = try await sut.fetchData()
                XCTFail("Fetch should have failed")
            } catch {
                expectation.fulfill()
            }
        }

        // Then
        wait(for: [expectation], timeout: 10)
    }
}
