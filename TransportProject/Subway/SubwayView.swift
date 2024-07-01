//
//  SubwayView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct SubwayView: View {
    @Bindable var store: StoreOf<SubwayFeature>
    @State private var text = ""
    
    init(store: StoreOf<SubwayFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            List {
                
//                ForEach( viewStore.state.result, id: \.self.id ) { item in
//                    
//                    
//                    Text("\(item.routeno.target)  \(item.routetp)").onTapGesture {
//                        viewStore.send(.tappedList(item))
//                    }
//                    
//                    
//                    
//                }
            }.listStyle(.plain)
                .navigationTitle("지하철 검색")
//                .searchable(text: $text).onSubmit(of: .search) {
//                    viewStore.send(.requestAPI(text))
//                }
            
            
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
