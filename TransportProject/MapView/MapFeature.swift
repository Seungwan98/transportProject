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
        var locations: [CLLocationCoordinate2D] = []
        var cameraPosition: MapCameraPosition = MapCameraPosition.automatic
        
        
    }
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        
        
        
        case onAppear
        case requestAPI(String)
        
        case result(RouteDTO)
        case resultText(String)
        case detination(IdentifiablePlace)
    }
    
    
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                
                return .run { [ id = state.routeId ] send in
                    let data = try await self.apiClient.fetchRoute(id)
                    
                    
                    
                    
                    await send(.result(data))
                    
                }
                
                
            case .requestAPI(let data):
                return .run { send in
                    let data = try await apiClient.fetchRoute(data)
                    await send(.result(data))
                }
            case .result(let model):
                model.routeResponse.routeBody.routes.route.forEach { route in
                    
                    state.result.append( IdentifiablePlace.init(lat: route.gpslati, long: route.gpslong, name: route.nodenm))
                    state.locations.append(CLLocationCoordinate2D.init(latitude: route.gpslati, longitude: route.gpslong) )
                }
                
                
                
                let manager = CLLocationManager()
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestAlwaysAuthorization()
                
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: state.locations.first!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                
                
                return .none
                
            case .detination(let destination):
                
                state.result.map {
                    
                    $0.location.distance(from: )
                    
                }
                
                return .none
                
            case .resultText(let resultText):
                let resultRoutes = state.result.filter {
                    $0.name.localizedStandardContains(resultText)
                }
                guard let location = resultRoutes.first?.location else {return .none}
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)))
                return .none
                
            case .binding(_):
                return .none
                
                
            }
            
            
            
        }
    }
}
