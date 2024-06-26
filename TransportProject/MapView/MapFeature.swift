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
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: MapFeature.State, rhs: MapFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        let busItem: BusItem
        var result: [IdentifiablePlace] = []
        var locations: [CLLocationCoordinate2D] = []
        var cameraPosition: MapCameraPosition = MapCameraPosition.automatic
        var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
        
        var locationManager = LocationManager()
        var alarm: Bool = false
        var anyCancellable = Set<AnyCancellable>()
        
        var isDestination = false
        
        var startPosition: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "", way: "")
        var destination: IdentifiablePlace = IdentifiablePlace(lat: 0, long: 0, name: "", way: "")
        var showAlert = false
        
    }
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        
        
        
        case requestAPI(String)
        case result(BusRouteDTO)
        case resultText(String)
        
        
        
        case position(IdentifiablePlace, Bool)
        case updateWay
    }
    
    
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                
                return .run { [ id = state.busItem.routeid  ] send in
                    let data = try await self.apiClient.fetchRoute(id)
                    await send(.result(data))
                    
                }
                
                
            case .requestAPI(let data):
                return .run { send in
                    let data = try await apiClient.fetchRoute(data)
                    await send(.result(data))
                }
            case .result(let model):
                var findEnd = false
                var name: String = ""
                model.routeResponse.routeBody.routes.route.forEach { route in
                    
                    if route.nodenm != state.busItem.endnodenm {
                        if findEnd {
                            name = "\n\(state.busItem.endnodenm) 방면 "
                        } else {
                            name  = "\n\(state.busItem.startnodenm) 방면 "
                            
                        }
                    } else {
                        findEnd = true
                    }
                    
                    
                    state.result.append( IdentifiablePlace.init(lat: route.gpslati, long: route.gpslong, name: route.nodenm, way: name))
                    state.locations.append(CLLocationCoordinate2D.init(latitude: route.gpslati, longitude: route.gpslong) )
                }
                
                
                
                let manager = CLLocationManager()
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestAlwaysAuthorization()
                
                state.userLocation = CLLocationCoordinate2D.init(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0)
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: state.userLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                
                
                return .none
                
            case .position(let position, let isDestination):
                
                if isDestination {
                    state.destination = position
                } else {
                    state.startPosition = position
                    
                }
                
                for ( index, value ) in state.result.enumerated() {
                    
                    
                    
                    if value.name == state.destination.name && value.way == state.destination.way || value.name == state.startPosition.name && value.way == state.startPosition.way {
                        state.result[index].color = .blue
                    } else {
                        state.result[index].color = .gray
                    }
                    
                }
                
                
                
                return .run { send in
                    await send(.updateWay)
                    
                }
                
            case .updateWay:
              
                
                
                if !state.destination.name.isEmpty && !state.startPosition.name.isEmpty {
                    state.locationManager.startLocation(destination: state.destination.location)
                    //                    state.cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: betaPosition.location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                }
                
                
                
                //                state.locationManager.$alarm.sink { value in
                //                    print("sink\(value)")
                //                }.store(in: &state.anyCancellable)
                
                
                
                
                
                
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
