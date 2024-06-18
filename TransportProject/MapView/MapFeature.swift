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

@Reducer
struct MapFeature {
    @Dependency(\.apiClient) var apiClient

    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: MapFeature.State, rhs: MapFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        let routeId : String
        var result : [Route] = []
        
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
            print("\(model) routeModel")
            state.result = model.routeResponse.routeBody.routes.route
            return .none

        case .tappedList(_):
            return .none
        }
        
    }
}
