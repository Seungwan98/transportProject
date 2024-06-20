//
//  ContentView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import MapKit
import ComposableArchitecture

struct MapView : View {
    @Bindable var store: StoreOf<MapFeature>
    @State private var text = ""
    
    
    init(store: StoreOf<MapFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }){ viewStore in
            
            @State var region = viewStore.region
            
            //                List {
            //
            ////                    ForEach( viewStore.state.result , id: \.self.id ) { item in
            //////                        NavigationLink(state: RootFeature.Path.State.detailScene() ) {
            ////                            Text("\(item.routeno.target)  \(item.routetp)")
            //////                        }
            ////
            ////                    }
            //                }.listStyle(.plain)
            //                    .navigationTitle("루트 검색")
            //                    .searchable(text: $text).onSubmit(of: .search){
            //                        viewStore.send(.requestAPI(text))
            //                    }.onAppear{
            //                        viewStore.send( .onAppear )
            //                    }
            //
            
            Map {
                
                
                
                ForEach(viewStore.state.result) { place in
                    Annotation(place.name, coordinate: place.location) {
                       
                        Button(action: {
                            print("place \(place.name)")

                        }) {
                            Image(systemName: "tram")
                                .resizable() // 이미지 크기 조정 가능
                                .frame(width: 10, height: 10)
                            
                        }.frame(width: 20, height: 20 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                     
                    }
                    
                    
                }
                
                MapPolyline(coordinates: viewStore.state.location).stroke(.blue, lineWidth: 2)
                
            }.onAppear {
                
                viewStore.send(.onAppear)
                
            }
            
        }
    }
}


#Preview {
    MapView(
        store : Store(initialState: MapFeature.State(routeId: "", nowLocation: CLLocationCoordinate2D())) {
            MapFeature()
        }
    )}
