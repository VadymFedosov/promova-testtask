//
//  NetworkService.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError
}

struct NetworkService {
    static let shared = NetworkService()
    private let urlString = "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json"
    
    func fetchCategories() async throws -> [AnimalCategoryResponse] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let categories = try JSONDecoder().decode([AnimalCategoryResponse].self, from: data)
        return categories
    }
}
