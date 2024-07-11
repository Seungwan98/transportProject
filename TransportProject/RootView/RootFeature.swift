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
                    
                    state.path.append(.detailScene(BusMapFeature.State(busItem: busItem)))
                    return .none
                    
                case .element(id: _, action: .subway(.pushResultView(let startPosition, let destination, let ways))):
                    print("들옴?")
                    state.path.append(.subwayResultScene(SubwayResultFeature.State(startPosition: startPosition, destination: destination, ways: ways)))
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
            case busScene(BusListFeature.State = .init())
            case subwayScene(SubwayListFeature.State = .init())
            case detailScene(BusMapFeature.State)
            case subwayResultScene(SubwayResultFeature.State )
        }
        
        enum Action {
            case bus(BusListFeature.Action)
            case detail(BusMapFeature.Action)
            case subway(SubwayListFeature.Action)
            case subwayResult(SubwayResultFeature.Action)
            
        }
        var body: some ReducerOf<Self> {
            Scope(state: \.busScene, action: \.bus ) {
                BusListFeature()
            }
            Scope(state: \.detailScene, action: \.detail ) {
                BusMapFeature()
            }
            Scope(state: \.subwayScene, action: \.subway ) {
                SubwayListFeature()
            }
            Scope(state: \.subwayResultScene, action: \.subwayResult) {
                SubwayResultFeature()
            }
            
        }
        
        
    }
}
