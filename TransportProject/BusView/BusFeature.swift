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
struct BusFeature {
    @Dependency(\.apiClient) var apiClient

    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: BusFeature.State, rhs: BusFeature.State) -> Bool {
            return lhs.result.count == rhs.result.count
        }
        var routeid: String = ""
        var result: [Item] = []
        var routeId: String = ""
        
    }
    enum Action: Equatable {
        static func == (lhs: BusFeature.Action, rhs: BusFeature.Action) -> Bool {
            return true
        }
        
        
       
        case onAppear
        case requestAPI(String)
        case result(BusDTO)
        case tappedList(String)
    }
    
    

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
            
        case .requestAPI(let data):
            return .run { send in
                let data = try await apiClient.fetchBus(Int(data) ?? 0)
                await send(.result(data))
            }
        case .result(let model):
            state.result = model.response.body.items.item
            
            return .none

        case .tappedList(_):
            return .none
        }
        
    }
}
