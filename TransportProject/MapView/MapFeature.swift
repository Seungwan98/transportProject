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
import BackgroundTasks
@Reducer
struct MapFeature {
    @Dependency(\.apiClient) var apiClient
    // var locationManager: LocationManager = LocationManager()
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: MapFeature.State, rhs: MapFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        let routeId: String
        var result: [IdentifiablePlace] = []
        var locations: [CLLocationCoordinate2D] = []
        var cameraPosition: MapCameraPosition = MapCameraPosition.automatic
        var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
        var destination: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "")
        
        
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
                
                state.userLocation = CLLocationCoordinate2D.init(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0)
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: state.userLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                
                
                return .none
                
            case .detination(let destination):
                var lowestDistance: CLLocationDistance = Double.infinity
                var startPosition: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "")
                _ = state.result.map {
                    
                    let distance = $0.location.distance(from: state.userLocation)
                    if distance < lowestDistance {
                        lowestDistance = distance
                        startPosition = $0
                    }
             
                }
                
                state.cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: startPosition.location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                state.destination = destination

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
