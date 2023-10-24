//
//  Errors.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/23/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingError
}
