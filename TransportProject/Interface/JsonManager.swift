//
//  FileManager.swift
//  TransportProject
//
//  Created by 양승완 on 7/3/24.
//

import Foundation
import ComposableArchitecture


@DependencyClient
struct JsonManager {
    var getForSubwayNm: (String) async throws -> [SubwayNmModel]
    var getForStatnId: (String) throws -> [SubwayNmModel]
    var getForThings: (String,String) throws -> [SubwayNmModel]
  
    
}

extension DependencyValues {
    var jsonManager: JsonManager {
        get { self[JsonManager.self] }
        set { self[JsonManager.self] = newValue }
    }
}
extension JsonManager: DependencyKey {
    static var liveValue = Self(
        getForSubwayNm: { subwayNm in
        guard let jsonPath = Bundle.main.url(forResource: "subway", withExtension: "json") else {
            
            return []  }
        // 4. 해당 위치의 파일을 Data로 초기화하기
        let data = try Data(contentsOf: jsonPath)
        let dto = try JSONDecoder().decode(SubwayNmDTO.self, from: data)
        
            
            
            return dto.datas.filter {
                return $0.subwayNm.rawValue == subwayNm
            }.map {
                $0.getModel()
            }
        
        
        }, getForStatnId: { statnId in
            guard let jsonPath = Bundle.main.url(forResource: "subway", withExtension: "json") else {
                
                return []  }
            // 4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: jsonPath)
            let dto = try JSONDecoder().decode(SubwayNmDTO.self, from: data)
            
                
                
                return dto.datas.filter {
                    return String($0.statnID) == statnId
                }.map {
                    $0.getModel()
                }
            
            
        }, getForThings: { statnNm, subwayNm in
            
            guard let jsonPath = Bundle.main.url(forResource: "subway", withExtension: "json") else {
                
                return []  }
            // 4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: jsonPath)
            let dto = try JSONDecoder().decode(SubwayNmDTO.self, from: data)
            
                
                
                return dto.datas.filter {
                    return String($0.statnNm) == statnNm && $0.subwayNm.rawValue == subwayNm
                }.map {
                    $0.getModel()
                }
    
        }
        )
    
   
}
