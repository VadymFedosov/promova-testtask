//
//  AnimalCategoriesView.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalCategoriesView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack {
                    if viewStore.isLoading {
                        ProgressView()
                    } else {
                        List {
                            ForEach(viewStore.categories) { category in
                                HStack {
                                    AsyncImage(url: URL(string: category.image)) { image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(category.title)
                                    Text(category.description)
                                    Text(category.status)
                                        .foregroundColor(category.status == "paid" ? .red : .green)
                                }
                                .onTapGesture {
                                    switch category.status {
                                    case "free":
                                        viewStore.send(.selectCategory(category))
                                    case "paid":
                                        viewStore.send(.showAlert(AlertState(
                                            title: TextState("Watch Ad to continue"),
                                            buttons: [
                                                .cancel(TextState("Cancel")),
                                                .default(TextState("Show Ad"), action: .send(.fetchCategories))
                                            ]
                                        )))
                                    default:
                                        viewStore.send(.showAlert(AlertState(
                                            title: TextState("Coming Soon"),
                                            buttons: [.default(TextState("Ok"))]
                                        )))
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Animal Categories")
                .alert(
                    store.scope(state: \.alert, action: AppAction.dismissAlert),
                    dismiss: .dismissAlert
                )
            }
        }
    }
}
