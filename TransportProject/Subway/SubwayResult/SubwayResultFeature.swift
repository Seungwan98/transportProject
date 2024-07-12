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
        var ways: [String]?
        
        var startStatnNm = ""
        var destinationStatnNm = ""
        
        var nowSubwayState = ""
        
        var startNm = ""
        var nextNm = ""
        var pickNm = ""
        var nextPickNm = ""
        
        
        var btnEnabled = false
        
        
        
        
        @Presents var alert: AlertState<Action.Alert>?
        
        
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.startPosition?.subwayID == rhs.startPosition?.subwayID &&
            lhs.destination?.subwayID == rhs.destination?.subwayID &&
            lhs.startStatnNm == rhs.startStatnNm &&
            lhs.destinationStatnNm == rhs.destinationStatnNm &&
            
            lhs.nextNm == rhs.nextNm &&
            lhs.nowSubwayState == rhs.nowSubwayState &&
            lhs.btnEnabled == rhs.btnEnabled
        }
        
        
        
    }
    enum Action {
        case onAppear
        
        case setResult([SubwayArriveModel])
        
        case setAlarm
        
        case ownSubway
        
        case cancel
        
        
        case stopAlarm
        
        case resetAlert
        
        case pop
        
        case alert(PresentationAction<Alert>)
        
        
        @CasePathable
        enum Alert {
            case pop
        }
        
        
        
    }
    
    
    enum CancelID { case timer }
    
    
    var body: some ReducerOf<Self> {
        
        
        
        Reduce { state, action in
            switch action {
                
            case .alert(.presented(.pop)):
                
                return .send(.pop)
            case .resetAlert:
                state.alert = AlertState {
                    
                    TextState("다른 경로를 선택하여 주세요")
                } actions: {
                    
                    ButtonState(action: .send(.pop), label: {
                        TextState("pop")
                    })
                    
                    ButtonState(role: .cancel) {
                        TextState("확인")
                    }
                }
                return .none
                
            case .onAppear:
                state.startStatnNm = state.startPosition?.statnNm ?? ""
                state.destinationStatnNm = state.destination?.statnNm ?? ""
                
                
                
                
                state.pickNm = state.startStatnNm
                if let ways = state.ways {
                    print("ways \(ways)")
                    guard let idx = ways.firstIndex(of: state.startStatnNm) else {return .send(.resetAlert)}
                    // 수정
                    guard let nextPickNm = ways[safe: idx + 1000] else {return .send(.resetAlert)}
                    
                    state.nextPickNm = nextPickNm
                    
                    print("stateNextNm \(state.nextNm)")
                    
                }
                
                
                
                
                
                
                return .run { send in
                    while true {
                        
                        
                        await send(.ownSubway)
                        
                        try await Task.sleep(for: .seconds(10))
                        
                        
                        
                        
                    }
                }.cancellable(id: CancelID.timer)
                
                
            case .setResult(let models):
                
                
                
                if let model = models.first {
                    
                    if model.statnNm == state.destinationStatnNm && model.arvlCD == "1" || model.arvlCD == "0" {
                        return .run { send in
                            await send(.cancel)
                            await send(.setAlarm)
                        }
                    }
                    
                    state.nextPickNm = model.statnTnm
                    
                    
                    if model.arvlCD == "1" || model.arvlCD == "2" {
                        
                        state.startNm = model.statnNm
                        state.nextNm = model.statnTnm
                        
                    } else {
                        state.startNm = model.statnFnm
                        state.nextNm = model.statnNm
                    }
                    
                    state.nowSubwayState = model.arvlMsg2
                    
                    print("arvlCD \(model.arvlCD)")
                    
                    
                } else {
                    
                    state.pickNm = state.nextPickNm
                    
                    print("else\(state.pickNm)")
                    
                    
                }
                
                
                return .none
                
                
            case .setAlarm:
                
                state.btnEnabled.toggle()
                
                BackgroundManager.shared.StartTimer()
                
                return .none
                
                
            case .ownSubway:
                
                
                
                let startPosition = state.startPosition
                let pickNm = state.pickNm
                
                
                
                return .run { send in
                    guard let data = try await apiClient.fetchSubwayArrive(pickNm) else { return }
                    
                    
                    let result = data.realtimeArrivalList.map { $0.getModel() }.filter {
                        
                        return $0.btrainNo == startPosition?.trainNo
                        
                    }
                    
                    await send(.setResult(result))
                    
                }
                
            case .cancel:
                return .cancel(id: CancelID.timer)
                
            case .stopAlarm:
                print("stopAlarm")
                state.btnEnabled = false
                
                BackgroundManager.shared.stopTime()
                return .none
                
                
                
                
                
            case .alert(_):
                return .none
            case .pop:
                
                print("is Poped")
                return .none
            }
            
        }.ifLet(\.$alert, action: \.alert)
        
    }
    
}
