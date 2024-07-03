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
import CoreLocation
@Reducer
struct SubwayResultFeature {

    @ObservableState
    struct State: Equatable {
        static func == (lhs: SubwayResultFeature.State, rhs: SubwayResultFeature.State) -> Bool {
            return true
        }
        
        var startPosition: SubwayModel?
        var destination: SubwayNmModel?
     
        
       
        
   
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
