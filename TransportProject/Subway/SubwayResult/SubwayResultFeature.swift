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
    @Dependency(\.jsonManager) var jsonManager
    
   

    @ObservableState
    struct State: Equatable {
        var state = 0
        var startPosition: SubwayModel?
        var destination: SubwayNmModel?
        
        var startStatnNm = "ㅁㄴㅇㅁㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ"
        var destinationStatnNm = "ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ"
        
        var nowSubwayState = ""
    
        var startNm = ""
        var beforeNm = ""
        var pickNm = ""
        
        var timerSec = 0
        

        
        
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.startPosition?.subwayID == rhs.startPosition?.subwayID &&
            lhs.destination?.subwayID == rhs.destination?.subwayID &&
            lhs.startStatnNm == rhs.startStatnNm &&
            lhs.destinationStatnNm == rhs.destinationStatnNm &&
           
            lhs.beforeNm == rhs.beforeNm &&
            lhs.nowSubwayState == rhs.nowSubwayState
        }
        
        
        
    }
    enum Action {
        case onAppear
        
        case setResult([SubwayArriveModel])
        
        case changed
        
        case ownSubway
        
        case cancel
        
                
        
    }
    
    
    enum CancelID { case timer }
    

    var body: some ReducerOf<Self> {
        
        
        
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                state.startStatnNm = state.startPosition?.statnNm ?? ""
                state.pickNm = state.startStatnNm
                state.destinationStatnNm = state.destination?.statnNm ?? ""
                
                
                
                
                
                return .run { send in
                    while true {
                        
                        
                        await send(.ownSubway)
                        
                        try await Task.sleep(for: .seconds(10))

                        

                        
                    }
                }.cancellable(id: CancelID.timer)
                
                
            case .setResult(let models):
                if models.isEmpty {
                    
                    state.pickNm = state.beforeNm

                } else {
                    state.startNm = models.first?.statnNm ?? ""
                    state.beforeNm = models.first?.statnFnm ?? ""
                    state.nowSubwayState = (models.first?.arvlMsg2 ?? "")

                    
                }
                
                print("\(state.startNm), \(state.beforeNm), \(state.nowSubwayState)")
                
                return .none
                
                
            case .changed:
                BackgroundManager.shared.scheduleApiFetch(nowState: state.nowSubwayState)
                return .none
                
                
            case .ownSubway:
                
                
                
                let startPosition = state.startPosition
                let pickNm = state.pickNm
                print("\(state.startNm)")
                
                return .run { send in
                    guard let data = try await apiClient.fetchSubwayArrive(pickNm) else { return }

                    
                    let result = data.realtimeArrivalList.map { $0.getModel() }.filter {
                        
                        return $0.btrainNo == startPosition?.trainNo
                        
                    }
                    
                    await send(.setResult(result))
                    
                }
                
            case .cancel:
                return .cancel(id: CancelID.timer)
                
                
                
     
            }
            
        }
        
    }
    
}
