//
//  Reducer.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var categories: [AnimalCategoryResponse] = []
    var alert: AlertState<AppAction>? = nil
    var isLoading: Bool = false
    var selectedCategory: AnimalCategoryResponse? = nil
    var facts: [FactContentResponse] = []
    var currentFactIndex: Int = 0
}

enum AppAction: Equatable {
    case fetchCategories
    case setCategories([AnimalCategoryResponse])
    case showAlert(AlertState<AppAction>)
    case dismissAlert
    case selectCategory(AnimalCategoryResponse)
    case fetchFacts
    case setFacts([FactContentResponse])
    case nextFact
    case previousFact
}

struct AppEnvironment {
    var networkService: NetworkService
    var realmService: RealmService
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .fetchCategories:
        state.isLoading = true
        return Effect.task {
            do {
                let categories = try await environment.networkService.fetchCategories()
                environment.realmService.saveCategories(categories)
                return .setCategories(categories)
            } catch {
                return .showAlert(AlertState(title: TextState("Failed to load categories")))
            }
        }
        .receive(on: environment.mainQueue)
        .eraseToEffect()
        
    case .setCategories(let categories):
        state.isLoading = false
        state.categories = categories
        return .none
        
    case .showAlert(let alert):
        state.alert = alert
        return .none
        
    case .dismissAlert:
        state.alert = nil
        return .none
        
    case .selectCategory(let category):
        state.selectedCategory = category
        return Effect.task {
            do {
                state.facts = category.content
                return .setFacts(category.content)
            } catch {
                return .showAlert(AlertState(title: TextState("Failed to load facts")))
            }
        }
        .eraseToEffect()
        
    case .setFacts(let facts):
        state.facts = facts
        state.currentFactIndex = 0
        return .none
        
    case .nextFact:
        state.currentFactIndex = min(state.currentFactIndex + 1, state.facts.count - 1)
        return .none
        
    case .previousFact:
        state.currentFactIndex = max(state.currentFactIndex - 1, 0)
        return .none
    }
}
