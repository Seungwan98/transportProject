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
  
    
 
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: SubwayFeature.State, rhs: SubwayFeature.State) -> Bool {
            lhs.resultLineName.count == rhs.resultLineName.count && lhs.resultDetail.count == rhs.resultDetail.count
        }
        
        // 호선 리스트
        var resultLineName: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "경의중앙선", "경춘선", "공항철도", "신분당선", "우이신실선"]
        
        
        // 지하철 모델 리스트
        var resultDetail: [SubwayModel] = []
        
        // 디테일 리스트 판별 변수
        var isLineList = true
        
   
    }
    enum Action {
        case onAppear
        case tappedList(String)
        
        case setResult([SubwayModel])

    }
    
    
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
  
                
                
            case .tappedList(let line):
                
                
                return .run { send in
                    print("line \(line)")
                    let data = try await apiClient.fetchSubway(line)
                    await send(.setResult(data.realtimePositionList))
                }

            
                
                
            case .setResult(let subwayModels):
                print(subwayModels)
                state.resultDetail = subwayModels
                state.isLineList = false

                
                

                return .none
            case .onAppear:
                return .none
            }
            
        }
        
    }
    
    
    
}
