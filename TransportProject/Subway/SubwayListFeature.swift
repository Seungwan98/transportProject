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
struct SubwayListFeature {
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.jsonManager) var jsonManager
    
    
    
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: SubwayListFeature.State, rhs: SubwayListFeature.State) -> Bool {
            lhs.resultLineName.count == rhs.resultLineName.count && lhs.resultDetail.count == rhs.resultDetail.count
        }
        
        // 호선 리스트
        var resultLineName: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "경의중앙선", "경춘선", "공항철도", "신분당선", "우이신설선", "경강선", "서해선", "수인분당선"]
        
        
        // 지하철 모델 리스트
        var resultDetail: [SubwayModel] = []
        
        // 목적지 모델 리스트
        var resultDestination: [SubwayNmModel] = []
        
        // 디테일 리스트 판별 변수
        var isLineList: Int = 0
        
        
    }
    enum Action {
        case onAppear
        case tappedList(String)
        case tappedDetailList(String)
        
        case setResult([SubwayModel])
        case setDestinationResult([SubwayNmModel])
        
    }
    
    
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
                
                
                
            case .tappedList(let line):
                
                
                return .run { send in
                    let data = try await apiClient.fetchSubway(line)
                    await send(.setResult(data.realtimePositionList.map {
                        $0.getModel()
                    }))
                }
                
                
                
                
            case .setResult(let subwayModels):
                //                print(subwayModels)
                
                state.resultDetail = subwayModels.sorted(by: { $1.statnNm > $0.statnNm })
                state.isLineList = 1
                return .none
                
                
                
            case .onAppear:
                return .none
 
                
            case .setDestinationResult(let result):
                state.resultDetail = []
                state.resultDestination = result
                state.isLineList = 2
                
                

                
                
                
                return .none
                
            case .tappedDetailList(let subwayNm):
                return .run { send in
                    let data = try await jsonManager.getModel(subwayNm)
                    
                    await send(.setDestinationResult(data))
                    
//                case .tappedDestinationList(let destination):
//                    return .
                }
            
                
                
            }
            
        }
        
    }
    
    
    
}
