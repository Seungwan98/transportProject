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
import Combine

struct AppleMapView: View {
    
    @StateObject var locationManager: LocationManager = LocationManager()
    @Bindable var store: StoreOf<AppleMapFeature>
    
    
    @State private var text = ""
    @State private var resultText = ""
    
    @State private var showAlert = false
    
    
    
    @State private var resultRoute: BusPicker = BusPicker(lat: 0, long: 0, name: "", way: "")
    
    
    
    init(store: StoreOf<AppleMapFeature> ) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            if self.locationManager.resultPositions.first != nil {
                HStack(spacing: 20) {
                    Text(self.locationManager.resultPositions.first?.name ?? "")
                    Image(systemName: "arrow.forward")
                    Text(self.locationManager.resultPositions.last?.name ?? "")

                }
            }
            
            
            
            
            
            
            
            Map(position: $store.cameraPosition) {
                
                UserAnnotation()
                
                
                
                
                ForEach( viewStore.state.result ) { place in
                    
                    
                    
                    Annotation(place.name + place.way, coordinate: place.location) {
                        
                        
                        
                        
                        Button(action: {
                            
                            
                            
                            viewStore.send(.alertButtonTapped(place))
                            


                            
                            
                        }, label: {
                            Image(systemName: "tram")
                                .resizable() // 이미지 크기 조정 가능
                                .frame(width: 10, height: 10)
                            
                        }).frame(width: 20, height: 20 ).foregroundColor(.white).background(place.color).clipShape(Circle())
                        
                    }
                    
                    
                }
                
                MapPolyline(coordinates: viewStore.state.locations).stroke(.blue, lineWidth: 2)
                
            }.mapControls {
                MapUserLocationButton()
                
            }.onAppear {
                
                viewStore.send(.onAppear(self.locationManager))
                
            }.searchable(text: $text, placement: .navigationBarDrawer(displayMode: .automatic)).onSubmit( of: .search ) {
                viewStore.send(.resultText(text))
            }
            
            if self.locationManager.timer {
                Button(action: {
                    self.locationManager.timer = false
                    
                }, label: {
                    
                    Text("알람 종료")
                    
                }).frame(height: 50)
            }
            
        }.alert($store.scope(state: \.alert, action: \.alert))
        
    }
    
    
          
}
//#Preview {
//    AppleMapView(
//        store: Store(initialState: AppleMapFeature.State(busItem: BusItem(endnodenm: "", endvehicletime: nil, routeid: "", routeno: nil, routetp: "", startnodenm: "", startvehicletime: ""))) {
//            AppleMapFeature()
//        }
//    )}
