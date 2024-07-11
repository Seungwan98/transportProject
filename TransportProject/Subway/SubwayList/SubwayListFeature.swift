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
import Alamofire
@Reducer
struct SubwayListFeature {
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.jsonManager) var jsonManager
    @Dependency(\.subwayState) var subwayState
    
    
    
    
    
    @ObservableState
    struct State: Equatable {
        static func == (lhs: SubwayListFeature.State, rhs: SubwayListFeature.State) -> Bool {
            lhs.resultDetail.elementsEqual(rhs.resultDetail) &&
            lhs.resultDestination.elementsEqual(rhs.resultDestination) &&
            lhs.isLineList == rhs.isLineList &&
            lhs.startPosition?.subwayID == rhs.startPosition?.subwayID
            
            
            
        }
        
        // 호선 리스트
        var resultLineName: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선", "경의중앙선", "경춘선", "공항철도", "신분당선", "우이신설선", "경강선", "서해선", "수인분당선"]
        
        
        // 지하철 모델 리스트
        var resultDetail: [SubwayModel] = []
        
        // 목적지 모델 리스트
        var resultDestination: [String] = []
        
        // 디테일 리스트 판별 변수
        var isLineList: Int = 0
        
        // 시작점 모델
        var startPosition: SubwayModel?
   
        var lineNameIdx = 99
        
        // AlertState
        @Presents var alert: AlertState<Action.Alert>?

    }
    enum Action {
        case onAppear
        
        case tappedList(String)
        case tappedDetailList(SubwayModel)
        case tappedDestinationList(String)
        
        case setResult([SubwayModel])
        case setDestinationResult([String])
        
        case pushResultView(SubwayModel, SubwayNmModel)
        
        case errorAlert
        case alert(PresentationAction<Alert>)
        
        
        
        @CasePathable
        enum Alert {}
        
        
        
    }
    
    
    
    var body: some ReducerOf<Self> {
        
        
        Reduce { state, action in
            switch action {
                
            case .errorAlert:
                state.alert = AlertState {
                    TextState("현재 운행중인 열차가 없습니다")
                } actions: {
                    
                   
                    ButtonState(role: .cancel) {
                        TextState("확인")
                    }
                }

                return .none
            case .alert:
                return .none
                

            case .setResult(let subwayModels):
                
                state.resultDetail = subwayModels.sorted(by: { $1.statnNm > $0.statnNm })
                state.isLineList = 1
                return .none
                
                
                
            case .onAppear:
                return .none
                
                
            case .setDestinationResult(let result):
                state.resultDestination = result
                state.isLineList = 2

                
                return .none
                
                
            case .tappedList(let line):
                state.lineNameIdx = state.resultLineName.firstIndex(of: line)!
                return .run { send in
                    guard let data = try await apiClient.fetchSubway(line) else {
                        
                        return await send(.errorAlert) }
                    
                    await send(.setResult(data.realtimePositionList.map {
                        $0.getModel()
                    }))
                }
                
            case .tappedDetailList(let subway):
                state.startPosition = subway
                let lineNameIdx = state.lineNameIdx

                
                return .run { send in
                    
                    let pickDesList = try subwayState.getWay(subway.statnNm, subway.statnTnm, lineNameIdx)

                    
                    await send(.setDestinationResult(pickDesList))
                    
                    
                }
                
            case .tappedDestinationList(let destination):
                guard let startPosition = state.startPosition else {return .none}
                
                
               // let data = try await jsonManager.getForSubwayNm(subway.subwayNm.rawValue)

                
                return .run { send in
                    
                    
                    await send(.pushResultView(startPosition, destination))
                    
                }
                
            case .pushResultView(_, _):
                return .none
                
            }
            
        }.ifLet(\.alert, action: \.alert)
    }
    
    
    
}
