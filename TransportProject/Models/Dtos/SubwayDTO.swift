// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subwayDTO = try? JSONDecoder().decode(SubwayDTO.self, from: jsonData)

import Foundation

// MARK: - SubwayDTO
struct SubwayDTO: Codable {
    let errorMessage: ErrorMessage
    let realtimePositionList: [RealtimePositionList]
}

// MARK: - ErrorMessage
struct ErrorMessage: Codable {
    let status: Int
    let code, message, link, developerMessage: String
    let total: Int
}

// MARK: - RealtimePositionList
struct RealtimePositionList: Codable {
    let beginRow, endRow, curPage, pageRow: JSONNull?
    let totalCount, rowNum, selectedCount: Int
    let subwayID: String
    let subwayNm: SubwayNm
    let statnID, statnNm, trainNo, lastRecptnDt: String
    let recptnDt, updnLine, statnTid, statnTnm: String
    let trainSttus, directAt, lstcarAt: String
    
    enum CodingKeys: String, CodingKey {
        case beginRow, endRow, curPage, pageRow, totalCount, rowNum, selectedCount
        case subwayID = "subwayId"
        case subwayNm
        case statnID = "statnId"
        case statnNm, trainNo, lastRecptnDt, recptnDt, updnLine, statnTid, statnTnm, trainSttus, directAt, lstcarAt
    }
}

enum SubwayNm: String, Codable {
    case gtxA = "GTX-A"
    case the1호선 = "1호선"
    case the2호선 = "2호선"
    case the3호선 = "3호선"
    case the4호선 = "4호선"
    case the5호선 = "5호선"
    case the6호선 = "6호선"
    case the7호선 = "7호선"
    case the8호선 = "8호선"
    case the9호선 = "9호선"
    case 경의중앙선 = "경의중앙선"
    case 경춘선 = "경춘선"
    case 공항철도 = "공항철도"
    case 신분당선 = "신분당선"
    case 우이신설선 = "우이신설선"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
