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
struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
struct MapView : View {
    @Bindable var store: StoreOf<MapFeature>
    @State private var text = ""
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    init(store: StoreOf<MapFeature>) {
        self.store = store
    }
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }){ viewStore in
       
           
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
            Map( interactionModes: [.rotate, .zoom, .all] ) {
                Marker("test1", coordinate: CLLocationCoordinate2D(latitude: 37.66924, longitude: 126.7330167))
                Marker("test2", coordinate: CLLocationCoordinate2D(latitude: 37.66923, longitude: 126.7330167))
                Marker("test3", coordinate: CLLocationCoordinate2D(latitude: 37.66922, longitude: 126.7330167))
                
                Annotation("annotation" , coordinate: CLLocationCoordinate2D(latitude: 37.66924, longitude: 126.7330167)){
                    Text("annotation")
                }
                
                
            }
            
    
        }
    }
}


#Preview {
    MapView(
        store : Store(initialState: MapFeature.State(routeId: "")) {
            MapFeature()
        }
    )}
