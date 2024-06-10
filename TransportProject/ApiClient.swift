//
//  ApiClient.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import ComposableArchitecture
import Alamofire

@DependencyClient
struct ApiClient {
    var fetch: (Int) async throws -> BusDTO
    
}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}
extension ApiClient: DependencyKey {
    static let liveValue = Self(
        fetch: { value in
            
            let parameters: [String: Any] = ["query": ""]
            let url = "http://apis.data.go.kr/1613000/BusRouteInfoInqireService/getRouteNoList?serviceKey=kc0al0dugGaSv1DDTZgLAx7uCBbhBaHU2rm1srUocfltPHQEozGrfNSEoeytjDRF%2B%2BAPtzscGL2s3aMLQ70pFQ%3D%3D&_type=json&cityCode=31100&routeNo=\(value)"
            
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(url, parameters: parameters).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(BusDTO.self, from: data)
                            print("result \(result)")
                            continuation.resume(returning: result)
                            
                        } catch {
                     
                                print("Error decoding JSON: \(error)")
                                continuation.resume(throwing: error)
                                
                         
                            
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
            
        })
}
