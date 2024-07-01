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
struct SubwayFeature {
    @Dependency(\.apiClient) var apiClient
//    @Dependency(\.locationManaging) var locationManaging
  
    
 
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: SubwayFeature.State, rhs: SubwayFeature.State) -> Bool {
            lhs.result.count == rhs.result.count
        }
        
        var result: [SubwayDTO] = []
    
        
    }
    enum Action {
        case onAppear
        

    }
    
    
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
                
                
            case .onAppear:
                return .none
            }
            
        }
        
    }
    
    
    
}
