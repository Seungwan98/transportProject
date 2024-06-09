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


struct BusFeature : Reducer {
    @Dependency(\.apiClient) var apiClient

    
    
    struct State: Equatable {
        var result: String = ""
        
    }
    enum Action: Equatable {
        case onAppear
        case requestAPI(String)
    }
    
    

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch(action){
        case .onAppear:
            return .run{ send in
                let data = try await apiClient.fetch()
                await send(.requestAPI(String(describing: data)))
            }
            
        case .requestAPI(let data):
            state.result = data
            return .none
        }
    }
}
