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

struct MapView: View {
    @Bindable var store: StoreOf<MapFeature>
    @State private var text = ""
    @State private var resultText = ""
    @State private var showAlert = false
    @State private var resultRoute: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "")
    
    
    init(store: StoreOf<MapFeature>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
          
            
            Map(position: $store.cameraPosition) {
            
                
                ForEach( viewStore.state.result ) { place in
                    Annotation(place.name, coordinate: place.location) {
                        
                        Button(action: {
                            
                            self.showAlert = true
                            self.resultRoute = place
                            
                            
                        }, label: {
                            Image(systemName: "tram")
                                .resizable() // 이미지 크기 조정 가능
                                .frame(width: 10, height: 10)
                            
                        }).frame(width: 20, height: 20 ).foregroundColor(.white).background(.blue).clipShape(Circle()).alert("목적지 선택", isPresented: $showAlert) {
                            Button("선택") {
                                viewStore.send(.detination(self.resultRoute))
                            }
                            Button("취소", role: .cancel) {}
                        } message: {
                            Text("\(self.resultRoute.name)을/를 목적지로 선택 하시겠습니까?")
                        }
                        
                    }
                    
                    
                }
                
                MapPolyline(coordinates: viewStore.state.locations).stroke(.blue, lineWidth: 2)
                
            }.onAppear {
                
                viewStore.send(.onAppear)
                
            }.searchable(text: $text).onSubmit( of: .search ) {
                viewStore.send(.resultText(text))
            }
        }
    }
    
    
    #Preview {
        MapView(
            store: Store(initialState: MapFeature.State(routeId: "", cameraPosition: MapCameraPosition.region(MKCoordinateRegion())  )) {
                MapFeature()
            }
        )}
}
