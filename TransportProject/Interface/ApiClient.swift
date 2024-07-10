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
    var fetchBus: (Int) async throws -> BusDTO
    var fetchRoute: (String) async throws -> BusRouteDTO
    var fetchSubway: (String) async throws -> SubwayDTO?
    var fetchSubwayArrive: (String) async throws -> SubwayArriveDTO?
    
}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}
extension ApiClient: DependencyKey {
    static let liveValue = Self(
        fetchBus: { value in
            
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
            
        },
        fetchRoute: { value in
            
            let parameters: [String: Any] = ["query": ""]
            let url = "http://apis.data.go.kr/1613000/BusRouteInfoInqireService/getRouteAcctoThrghSttnList?serviceKey=kc0al0dugGaSv1DDTZgLAx7uCBbhBaHU2rm1srUocfltPHQEozGrfNSEoeytjDRF%2B%2BAPtzscGL2s3aMLQ70pFQ%3D%3D&pageNo=1&numOfRows=10000&_type=json&cityCode=31100&routeId=\(value)"
            
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(url, parameters: parameters).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(BusRouteDTO.self, from: data)
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
            
        }, fetchSubway: { value in
            var nextValue = ""
            print("\(nextValue) enxtNval")
            let parameters: [String: Any] = ["query": ""]
            let url = "http://swopenapi.seoul.go.kr/api/subway/71416e504973696e35354d774c4f73/json/realtimePosition/0/1000/\(value)"
            
            
            //            "http://swopenapi.seoul.go.kr/api/subway/726773506b73696e37354f6e517353/json/realtimePosition/0/1000/\(value)"
            
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(url, parameters: parameters).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(SubwayDTO.self, from: data)
                            
                            continuation.resume(returning: result)
                            
                        } catch {
                            
                            print("Error decoding JSON: \(error)")
                            continuation.resume(returning: nil)
                            
                            
                            
                            
                        }
                    case .failure(let error):
                        continuation.resume(returning: nil)
                    }
                }
            }
            
        }, fetchSubwayArrive: { value in
            
            
            let parameters: [String: Any] = ["query": ""]
            let url = "http://swopenAPI.seoul.go.kr/api/subway/71416e504973696e35354d774c4f73/json/realtimeStationArrival/0/1000/\(value)"
            //            "http://swopenAPI.seoul.go.kr/api/subway/726773506b73696e37354f6e517353/json/realtimeStationArrival/0/1000/\(value)"
            
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(url, parameters: parameters).responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(SubwayArriveDTO.self, from: data)
                            continuation.resume(returning: result)
                            
                        } catch {
                            
                            print("Error decoding JSON: \(error)")
                            continuation.resume(returning: nil )
                            
                            
                            
                        }
                    case .failure(let error):
                        continuation.resume(returning: nil)
                    }
                }
            }
        }
        
        
        
    )
}
