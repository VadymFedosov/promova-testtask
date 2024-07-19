//
//  AnimalCategoryResponse.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation

struct AnimalCategoryResponse: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: String
    let content: [FactContentResponse]
}
