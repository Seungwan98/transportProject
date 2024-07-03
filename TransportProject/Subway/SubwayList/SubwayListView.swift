//
//  SubwayView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct SubwayListView: View {
    @Bindable var store: StoreOf<SubwayListFeature>
    @State private var text = ""
    
    init(store: StoreOf<SubwayListFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            switch viewStore.isLineList {
            case 0:
                List(viewStore.resultLineName, id: \.self) { text in
                    Button(action: {
                        viewStore.send(.tappedList(text))
                    }, label: {
                        Text("\(text)")
                    })
                }.listStyle(.plain).navigationTitle("탑승 지하철 선택")
                //                .searchable(text: $text).onSubmit(of: .search) {
                //                    viewStore.send(.requestAPI(text))
                //                }
            case 1:
                List {
                    ForEach(viewStore.state.resultDetail, id: \.id) { model in
                        
                        Button(action: {
                            viewStore.send(.tappedDetailList(model))
                        }, label: {
                            HStack {
                                VStack {
                                    HStack {
                                        Text("\(model.statnNm) \(model.getWay())")
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(model.trainNo)")
                                        Spacer()
                                    }
                                }
                                Spacer()
                                
                                Text("\(model.recptnDt.getFormatted()) \(model.getState())")
                                
                            }
                        })
                        
                    }
                    
                }.listStyle(.plain)
                    .navigationTitle("탑승 지하철 선택").searchable(text: $text).onSubmit(of: .search) {
                        //   viewStore.send(.search(text))
                    }
                
            case 2:
                List {
                    ForEach(viewStore.state.resultDestination, id: \.id) { model in
                        
                        Button(action: {
                            viewStore.send(.tappedDestinationList(model))
                        }, label: {
                            Text("\(model.statnNm)")
                            
                        })
                        
                    }
                    
                }.listStyle(.plain)
                    .navigationTitle("목적지 선택").searchable(text: $text).onSubmit(of: .search) {
                        //   viewStore.send(.search(text))
                    }
            default:
                Text("err")
                
            }
          
        }.alert($store.scope(state: \.alert, action: \.alert))
    }
}

//
// #Preview {
//    BusView(
//        store : Store(initialState: BusFeature.State() {
//            BusFeature()
//        }
//    )}
