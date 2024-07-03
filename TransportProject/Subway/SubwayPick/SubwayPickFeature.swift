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
struct SubwayPickFeature {

    @ObservableState
    struct State: Equatable {
     
        
       
        
   
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
