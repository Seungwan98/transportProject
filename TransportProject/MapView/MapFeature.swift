//
//  Feature.swift
//  runningProject
//
//  Created by 양승완 on 6/1/24.
//

import Foundation
import ComposableArchitecture
import Combine
import SwiftUI
import MapKit
import CoreLocation
@Reducer
struct MapFeature {
    @Dependency(\.apiClient) var apiClient

    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: MapFeature.State, rhs: MapFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        let routeId: String
        var result: [IdentifiablePlace] = []
        var location: [CLLocationCoordinate2D] = []
        var region: MKCoordinateRegion = MKCoordinateRegion()
        var nowLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
    }
    enum Action {
     
    
       
        case onAppear
        case requestAPI(String)
        
        //향후 DTO로 수정
        case result(RouteDTO)
        case tappedList(String)
    }
    
    

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch(action){
        case .onAppear:
            
            return .run { [ id = state.routeId ] send in
                let data = try await self.apiClient.fetchRoute(id)
                
                
                
                
                await send(.result(data))
                
            }
                            
            
        case .requestAPI(let data):
            return .run{ send in
                let data = try await apiClient.fetchRoute(data)
                await send(.result(data))
            }
        case .result(let model):
//            print("\(model) routeModel")
            model.routeResponse.routeBody.routes.route.forEach { route in
                
                state.result.append( IdentifiablePlace.init(lat: route.gpslati, long: route.gpslong, name: route.nodenm))
                state.location.append(CLLocationCoordinate2D.init(latitude: route.gpslati, longitude: route.gpslong) )
            }
            state.region = MKCoordinateRegion(center: state.location.first!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            
            let manager = CLLocationManager()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            
            state.nowLocation = manager.location!.coordinate
            
            
            return .none

        case .tappedList(_):
            return .none
        }
        
    }
}
