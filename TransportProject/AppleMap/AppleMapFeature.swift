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
struct AppleMapFeature {
    @Dependency(\.apiClient) var apiClient
    //    @Dependency(\.locationManaging) var locationManaging
    
    
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: AppleMapFeature.State, rhs: AppleMapFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        var locationManager: LocationManager?
        
        let busItem: BusItem
        var result: [BusPicker] = []
        var locations: [CLLocationCoordinate2D] = []
        var cameraPosition: MapCameraPosition = MapCameraPosition.automatic
        var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init()
        
        
        var anyCancellable = Set<AnyCancellable>()
        
        var isDestination = false
        
        var startPosition: BusPicker = BusPicker(lat: 0, long: 0, name: "", way: "")
        var destination: BusPicker = BusPicker(lat: 0, long: 0, name: "", way: "")
        
        
        
        @Presents var alert: AlertState<Action.Alert>?
        
    }
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear(LocationManager)
        
        case requestAPI(String)
        case result(BusRouteDTO)
        case resultText(String)
        
        
        case alert(PresentationAction<Alert>)
        case alertButtonTapped(BusPicker)
        case resetAlert
        @CasePathable
        enum Alert {
            case position(Bool, BusPicker)
        }
        
        
        
        
    }
    
    
    
    var body: some ReducerOf<Self> {
        
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear(let locationManager):
                state.locationManager = locationManager
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
                            name = "\n\(state.busItem.startnodenm) 방면 "
                        } else {
                            name  = "\n\(state.busItem.endnodenm) 방면 "
                            
                        }
                    } else {
                        findEnd = true
                    }
                    
                    
                    state.result.append( BusPicker.init(lat: route.gpslati, long: route.gpslong, name: route.nodenm, way: name))
                    state.locations.append(CLLocationCoordinate2D.init(latitude: route.gpslati, longitude: route.gpslong) )
                }
                
                
                
                let manager = CLLocationManager()
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestAlwaysAuthorization()
                
                state.userLocation = CLLocationCoordinate2D.init(latitude: manager.location?.coordinate.latitude ?? 0, longitude: manager.location?.coordinate.longitude ?? 0)
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: state.userLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                
                
                return .none
                
                
                
            case .resultText(let resultText):
                let resultRoutes = state.result.filter {
                    $0.name.localizedStandardContains(resultText)
                }
                guard let location = resultRoutes.first?.location else {return .none}
                state.cameraPosition = MapCameraPosition.region( MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)))
                return .none
                
            case .binding(\.locationManager):
                return .none
                
            case .alert(.presented(.position(let isDestination, let position))):
                
                
                print("position \(position)")
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
                
                
                if !state.destination.name.isEmpty && !state.startPosition.name.isEmpty {
                    //                    state.cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: betaPosition.location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
                    
                    var behind = true
                    var startIndex: Int?
                    var lastIndex: Int?
                    
                    for (index, value) in state.result.enumerated() {
                        
                        
                        
                        if behind && value.name == state.destination.name {
                            lastIndex = index
                            break
                        }
                        
                        if value.name == state.startPosition.name {
                            behind = true
                            startIndex = index
                        }
                        
                    }
                    
                    if let startIndex = startIndex, let lastIndex = lastIndex {
                        
                        state.result = Array(state.result[startIndex...lastIndex]).map {
                            $0.changeToBlue()
                        }
                        state.locations = state.result.map {
                            
                            return $0.location
                        }
                        
                        state.locationManager?.startLocation(positions: state.result)
                        
                    } else {
                        // 경로가 존재하지 않을때.
                        // gray로 초기화.
                        let lastResult = state.result.map {
                            $0.changeToGray()
                        }
                        
                        // 이전 전체 경로
                        state.result = lastResult
                        
                        //  이전 시작점, 도착점 초기화
                        state.destination = BusPicker(lat: 0, long: 0, name: "", way: "")
                        state.startPosition = BusPicker(lat: 0, long: 0, name: "", way: "")
                        
                        return .run { send in
                            await send(.resetAlert)
                        }
                        
                    }
                    
                    
                    
                } else {
                    
                    print("why here")
                    
                }
                
                
                return .none
                
                
                
            case .alert:
                return .none
                
            case .alertButtonTapped(let position):
                state.alert = AlertState {
                    TextState("출발지나 목적지를 지정해주세요")
                } actions: {
                    
                    ButtonState(action: .position(false, position)) {
                        TextState("출발지")
                    }
                    ButtonState(action: .position(true, position)) {
                        TextState("목적지")
                    }
                    ButtonState(role: .cancel) {
                        TextState("취소")
                    }
                }
                return .none
                
            case .resetAlert:
                state.alert = AlertState {
                    TextState("잘못된 경로입니다")
                } actions: {
                    
                    ButtonState(role: .cancel) {
                        TextState("확인")
                    }
                    
                } message: {
                    TextState("출발지와 목적지를 다시 선택 해주세요")
                }
                
                return .none
                
                
                
                
                
            case .binding(_):
                return .none
                
            }
        }.ifLet(\.$alert, action: \.alert)
        
        
        
    }
}
