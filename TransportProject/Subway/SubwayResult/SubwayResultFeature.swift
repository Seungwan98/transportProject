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
    
    @ObservableState
    struct State: Equatable {
        var state = 0
        var startPosition: SubwayModel?
        var destination: SubwayNmModel?
        
        var nowSubwayNm = "ㅁㅁㅁ"
        var nowSubwayState = ""
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.startPosition?.subwayID == rhs.startPosition?.subwayID &&
            lhs.destination?.subwayID == rhs.destination?.subwayID &&
            lhs.nowSubwayNm == rhs.nowSubwayNm &&
            lhs.nowSubwayState == rhs.nowSubwayState
        }
        
        
        
    }
    enum Action {
        case onAppear
        
        case setResult([SubwayModel])
        
        case changed
        
        
    }
    
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
                
            case .onAppear:
                
                
                guard let subwayNmModel = state.destination, let trainNo = state.startPosition?.trainNo else {return .none}
                
                print("guardlet")
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(10))
                        guard let data = try await apiClient.fetchSubway(subwayNmModel.subwayNm.rawValue) else {return}
                        
                        await send(.setResult(data.realtimePositionList.map { $0.getModel() }.filter {
                            
                            return $0.trainNo == trainNo
                            
                        }))
                        
                    }
                    
                    
                    
                }.cancellable(id: CancelID.timer)
                
            case .setResult(let models):
                print(state.state)
                print(models)
                state.nowSubwayNm = (models.first?.statnNm ?? "") + (models.first?.getState() ?? "")
                return .none
                
                
            case .changed:
                BackgroundManager.shared.scheduleApiFetch(nowState: state.nowSubwayNm)
                return .none
            }
            
        }
        
    }
    
    
    
}
