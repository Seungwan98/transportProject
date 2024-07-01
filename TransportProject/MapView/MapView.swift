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

struct MapView: View {
    
    @StateObject var locationManager: LocationManager = LocationManager()
    @Bindable var store: StoreOf<MapFeature>
    
    
    @State private var text = ""
    @State private var resultText = ""
    
    @State private var showAlert = false
    
    
    
    @State private var resultRoute: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "", way: "")
    
    
    
    init(store: StoreOf<MapFeature> ) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            
            Text(
                
                "\(self.locationManager.resultPositions.first?.name ?? "") -> \(self.locationManager.resultPositions.last?.name ?? "") "
            )
            
            Map(position: $store.cameraPosition) {
                
                UserAnnotation()
                
                
                
                
                ForEach( viewStore.state.result ) { place in
                    
                    
                    
                    Annotation(place.name + place.way, coordinate: place.location) {
                        
                        
                        
                        
                        Button(action: {
                            self.resultRoute = place
                            self.showAlert = true

                            
                            
                            
                            
                            
                        }, label: {
                            Image(systemName: "tram")
                                .resizable() // 이미지 크기 조정 가능
                                .frame(width: 10, height: 10)
                            
                        }).frame(width: 20, height: 20 ).foregroundColor(.white).background(place.color).clipShape(Circle()).alert("\(place.name + place.way) \(self.showAlert) 선택", isPresented: $showAlert) {
                            Button("목적지") {
                                self.showAlert = false
                                print("목적지")
                                
                                viewStore.send(.position(self.resultRoute, true))

                                
                            }
                            Button("출발지") {
                                print("출발지")
                                self.showAlert = false

                                viewStore.send(.position(self.resultRoute, false))

                                
                            }
                            Button("취소", role: .cancel) {

                                
                            }
                        } message: {
                            Text("선택해주세요")
                            //                            Text("\(self.resultRoute.name) 을/를 \(self.place)로 선택 하시겠습니까?")
                        }
                        
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
        }
        
    }
    
    
    //        #Preview {
    //            MapView(
    //                store: Store(initialState: MapFeature.State(busItem: BusItem.init(endnodenm: "", endvehicletime: nil, routeid: "", routeno: Endvehicletime(from: Decoder()), routetp: "", startnodenm: "", startvehicletime: ""), cameraPosition: MapCameraPosition.region(MKCoordinateRegion())  )) {
    //                    MapFeature()
    //                }
    //            )}
}
