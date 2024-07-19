//
//  promova_testtaskApp.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct MyApp: App {
    private let store = Store(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment(
            networkService: NetworkService.shared,
            realmService: RealmService(),
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
        )
    )
    
    var body: some Scene {
        WindowGroup {
            AnimalCategoriesView(store: store)
        }
    }
}

