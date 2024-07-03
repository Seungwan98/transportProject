//
//  Feature.swift
//  runningProject
//
//  Created by 양승완 on 6/1/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI


@Reducer
struct RootFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var path = StackState<Path.State>()
    }
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .path(action):
                switch action {
                case .element(id: _, action: .bus(.tappedList(let busItem))):
                    
                    state.path.append(.detailScene(MapFeature.State(busItem: busItem)))
                    return .none
                    
                
                default:
                    return .none
                }
                
            }
            
        }.forEach(\.path, action: \.path) {
            Path()
        }
        
    }
    
    
}
extension RootFeature {
    @Reducer
    struct Path {
        
        @ObservableState
        enum State: Equatable {
            case busScene(BusFeature.State = .init())
            case subwayScene(SubwayListFeature.State = .init())
            case detailScene(MapFeature.State)
        }
        
        enum Action {
            case bus(BusFeature.Action)
            case detail(MapFeature.Action)
            case subway(SubwayListFeature.Action)
            
        }
        var body: some ReducerOf<Self> {
            Scope(state: \.busScene, action: \.bus ) {
                BusFeature()
            }
            Scope(state: \.detailScene, action: \.detail ) {
                MapFeature()
            }
            Scope(state: \.subwayScene, action: \.subway ) {
                SubwayListFeature()
            }
        }
        
        
    }
}
