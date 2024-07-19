//
//  AnimalCategory.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation
import RealmSwift

class AnimalCategory: Object {
    @Persisted var title: String = ""
    @Persisted var acDescription: String = ""
    @Persisted var image: String = ""
    @Persisted var order: Int = 0
    @Persisted var status: String = ""
    @Persisted var content: List<FactContent> = List<FactContent>()
}
