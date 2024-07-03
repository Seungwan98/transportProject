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
    var getModel: (String) async throws -> [SubwayNmModel]
  
    
}

extension DependencyValues {
    var jsonManager: JsonManager {
        get { self[JsonManager.self] }
        set { self[JsonManager.self] = newValue }
    }
}
extension JsonManager: DependencyKey {
    static var liveValue = Self(
        getModel: { subwayNm in
        guard let jsonPath = Bundle.main.url(forResource: "subway", withExtension: "json") else {
            
            return []  }
        // 4. 해당 위치의 파일을 Data로 초기화하기
        let data = try Data(contentsOf: jsonPath)
        let dto = try await JSONDecoder().decode(SubwayNmDTO.self, from: data)
        
            
            
            return dto.datas.filter {
                return $0.subwayNm.rawValue == subwayNm
            }.map {
                $0.getModel()
            }
        
        
    }
        )
    
   
}
