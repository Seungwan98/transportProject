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
    
    @Dependency(\.apiClient) var apiClient
    
    private var isOwn = true
   
    
    @ObservableState
    struct State: Equatable {
        var state = 0
        var startPosition: SubwayModel?
        var destination: SubwayNmModel?
        
        var nowSubwayNm = "시작"
        var nowSubwayState = "끝끝"
    
        var startNm = ""
        var nextNm = ""
        
        var isOwn = false
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.startPosition?.subwayID == rhs.startPosition?.subwayID &&
            lhs.destination?.subwayID == rhs.destination?.subwayID &&
            lhs.nowSubwayNm == rhs.nowSubwayNm &&
            lhs.nowSubwayState == rhs.nowSubwayState
        }
        
        
        
    }
    enum Action {
        case onAppear
        
        case setResult([SubwayArriveModel])
        
        case changed
        
        case ownSubway
        
        case nextSubway
        
        case setNewValue
        
    }
    
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
                
            case .onAppear:

                
                guard let subwayNmModel = state.destination, let startPosition = state.startPosition else {
                    print("startPosition is Nil")
                    return .none}
                
                state.startNm = startPosition.statnNm
                
                
                return .run { send in
                    while true {
                        print("while")

                        try await Task.sleep(nanoseconds: 100)
                        if self.isOwn {
                            await send(.ownSubway)
                            
                            
                        }
                        
                        else {
                            await send(.nextSubway)
                        }
                        
                        
                        
                        
                        
                        
                    }
                }.cancellable(id: CancelID.timer)
                
                
            case .setResult(let models):
                
                
                state.nextNm = models.first?.statnTid ?? ""
                state.nowSubwayNm = (models.first?.arvlMsg2 ?? "")
                return .none
                
                
            case .changed:
                BackgroundManager.shared.scheduleApiFetch(nowState: state.nowSubwayNm)
                return .none
            case .ownSubway:
                
             
                
                let startPosition = state.startPosition
                let startNm = state.startNm
                
                return .run { send in
                    guard let data = try await apiClient.fetchSubwayArrive(startNm) else {
                        await send(.setNewValue)
                        return }
                    
                    let result = data.realtimeArrivalList.map { $0.getModel() }.filter {
                        
                        return $0.btrainNo == startPosition?.trainNo
                        
                    }
                    
                    await send(.setResult(result))
                    
                }
                
            case .nextSubway:
                let statnm = state.nextNm
                let startPosition = state.startPosition
                return .run { send in
                    guard let data = try await apiClient.fetchSubwayArrive(statnm) else {return}
                    
                    let result = data.realtimeArrivalList.map { $0.getModel() }.filter {
                        
                        return $0.btrainNo == startPosition?.trainNo
                        
                    }
                    
                    await send(.setResult(result))
                    
                    
                }
                
            case .setNewValue:
                // state.isOwn.toggle()
                
                state.startNm = state.nextNm
                return .none
            }
            
            
            
            
        }
        
    }
    
    
    
}
