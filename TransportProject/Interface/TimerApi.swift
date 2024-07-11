//
//  TimerApi.swift
//  TransportProject
//
//  Created by 양승완 on 7/4/24.
//

import Foundation

struct TimerApi {
    
    func setTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: Selector, userInfo: <#T##Any?#>, repeats: <#T##Bool#>)

        
    }
    
    
    func fetchApi(subwayNmModel: SubwayNmModel, statnNm: String) async throws -> String {
        let data = try await apiClient.fetchSubway(subwayNmModel.subwayNm.rawValue)
        var result = ""
        _ = data?.realtimePositionList.map { data in
            if data.statnNm == statnNm {
                result = "\(data.statnNm) + \(data.trainSttus)"
            }
        }
        return result
        
        

    }
}
