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
            if viewStore.isLineList {
                List(viewStore.resultLineName, id: \.self) { text in
                    Button(action: {
                        viewStore.send(.tappedList(text))
                    }) {
                        Text("\(text)")
                    }
                }.listStyle(.plain)
                    .navigationTitle("지하철 검색")
                //                .searchable(text: $text).onSubmit(of: .search) {
                //                    viewStore.send(.requestAPI(text))
                //                }
                
            } else {
                
                List {
                    ForEach(viewStore.state.resultDetail, id: \.statnID) { model in
                        
                        Button(action: {
                            print(model.statnNm)
                        }) {
                            Text("\(model.statnNm)")
                        }
                        
                    }
                    
                }.listStyle(.plain)
                    .navigationTitle("지하철 검색")
                //                .searchable(text: $text).onSubmit(of: .search) {
                //                    viewStore.send(.requestAPI(text))
                //                }
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
