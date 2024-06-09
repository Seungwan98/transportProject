// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let model = try? JSONDecoder().decode(Model.self, from: jsonData)

import Foundation

// MARK: - Model
struct Model: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let header: Header
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
}

// MARK: - Item
struct Item: Codable {
    let endnodenm: String
    let endvehicletime: Int
    let routeid: String
    let routeno: Routeno
    let routetp: Routetp
    let startnodenm: String
    let startvehicletime: Routeno
}

enum Routeno: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Routeno.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Routeno"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Routetp: String, Codable {
    case 간선버스 = "간선버스"
    case 광역버스 = "광역버스"
    case 급행버스 = "급행버스"
    case 마을버스 = "마을버스"
    case 외곽버스 = "외곽버스"
    case 첨단버스 = "첨단버스"
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
}
