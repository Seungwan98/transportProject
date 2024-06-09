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
    var fetch: () async throws -> String

}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}
extension ApiClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            let url = "https://apis.data.go.kr/1613000/BusRouteInfoInqireService/getRouteNoList?serviceKey=kc0al0dugGaSv1DDTZgLAx7uCBbhBaHU2rm1srUocfltPHQEozGrfNSEoeytjDRF%2B%2BAPtzscGL2s3aMLQ70pFQ%3D%3D&pageNo=1&numOfRows=1000&_type=json&cityCode=25"

            return try await withCheckedThrowingContinuation { continuation in
                AF.request(url).responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        print("Success with JSON: \(data)")
                        continuation.resume(returning: "success\(data)")
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    )
}
