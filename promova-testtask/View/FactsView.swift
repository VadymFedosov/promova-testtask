//
//  FactsView.swift
//  promova-testtask
//
//  Created by user on 19.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct FactsView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if let category = viewStore.selectedCategory {
                    Text(category.title)
                        .font(.largeTitle)
                    Text(category.description)
                        .font(.subheadline)
                    
                    if !viewStore.facts.isEmpty {
                        let fact = viewStore.facts[viewStore.currentFactIndex]
                        AsyncImage(url: URL(string: fact.image)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Text(fact.fact)
                            .padding()
                        
                        HStack {
                            Button("Previous") {
                                viewStore.send(.previousFact)
                            }
                            Spacer()
                            Button("Next") {
                                viewStore.send(.nextFact)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle(Text(viewStore.selectedCategory?.title ?? ""), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        viewStore.send(.dismissAlert)
                    }
                }
            }
        }
    }
}
