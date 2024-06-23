// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let routeDTO = try? JSONDecoder().decode(RouteDTO.self, from: jsonData)

import Foundation

// MARK: - RouteDTO
struct RouteDTO: Codable {
    let routeResponse: RouteResponse
    enum CodingKeys: String, CodingKey {
        case routeResponse = "response"
        
    }
}

// MARK: - Response
struct RouteResponse: Codable {
    let routeHeader: RouteHeader
    let routeBody: RouteBody
    
    enum CodingKeys: String, CodingKey {
        case routeHeader = "header"
        case routeBody = "body"
        
    }
}

// MARK: - Body
struct RouteBody: Codable {
    let routes: Routes
    let numOfRows, pageNo, totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case routes = "items"
        case numOfRows = "numOfRows"
        case pageNo = "pageNo"
        case totalCount = "totalCount"
        
        
    }
    
}

// MARK: - Items
struct Routes: Codable {
    let route: [Route]
    enum CodingKeys: String, CodingKey {
        case route = "item"
        
        
    }
}

// MARK: - Item
struct Route: Codable {
    let gpslati, gpslong: Double
    let nodeid, nodenm: String
    let nodeno: Int?
    let nodeord: Int
    let routeid: String
}


// MARK: - Header
struct RouteHeader: Codable {
    let resultCode, resultMsg: String
}
