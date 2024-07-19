//
//  RealmService.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation
import RealmSwift

struct RealmService {
    private let realm = try! Realm()
    
    func saveCategories(_ categories: [AnimalCategoryResponse]) {
        try? realm.write {
            realm.delete(realm.objects(AnimalCategory.self))
            
            for categoryResponse in categories {
                let category = AnimalCategory()
                category.title = categoryResponse.title
                category.acDescription = categoryResponse.description
                category.image = categoryResponse.image
                category.order = categoryResponse.order
                category.status = categoryResponse.status
                
                for fact in categoryResponse.content {
                    let factContent = FactContent()
                    factContent.fact = fact.fact
                    factContent.image = fact.image
                    category.content.append(factContent)
                }
                
                realm.add(category)
            }
        }
    }
    
    func getCategories() -> Results<AnimalCategory> {
        realm.objects(AnimalCategory.self).sorted(byKeyPath: "order", ascending: true)
    }
}
