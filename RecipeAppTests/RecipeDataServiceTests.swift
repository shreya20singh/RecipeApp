//
//  RecipeDataServiceTests.swift
//  RecipeAppTests
//
//  Created by Shreya Singh on 10/25/23.
//

import XCTest
@testable import RecipeApp

class RecipeDataServiceTests: XCTestCase {
    var sut: RecipeDataService!
    var mockRecipeID = "52893"

    override func setUp() {
        super.setUp()
        sut = RecipeDataService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchRecipeSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetching recipe")

        // When
        Task {
            do {
                let recipe = try await sut.fetchRecipe(for: mockRecipeID)
                XCTAssertNotNil(recipe)
                expectation.fulfill()
            } catch {
                XCTFail("Failed to fetch recipe: \(error)")
            }
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testFetchRecipeFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetching recipe")

        // When
        Task {
            do {
                // Provide an invalid recipe ID to trigger a failure
                let _ = try await sut.fetchRecipe(for: "invalid_recipe_id")
                XCTFail("Fetch should have failed")
            } catch {
                expectation.fulfill()
            }
        }

        // Then
        wait(for: [expectation], timeout: 5)
    }
}
