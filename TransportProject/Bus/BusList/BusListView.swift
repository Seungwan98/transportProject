//
//  ContentView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct BusListView: View {
    @Bindable var store: StoreOf<BusListFeature>
    @State private var text = ""
    
    init(store: StoreOf<BusListFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            List {
                
                ForEach( viewStore.state.result, id: \.self.id ) { item in
                    
                    
                    Text("\(item.routeno.target)  \(item.routetp)").onTapGesture {
                        viewStore.send(.tappedList(item))
                    }
                    
                    
                    
                }
            }.listStyle(.plain)
                .navigationTitle("버스 검색")
                .searchable(text: $text).onSubmit(of: .search) {
                    viewStore.send(.requestAPI(text))
                }
            
            
        }
    }
    
   
    
}

//
// #Preview {
//    BusView(
//        store : Store(initialState: BusFeature.State() {
//            BusFeature()
//        }
//    )}
