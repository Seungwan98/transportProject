//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let model = try? JSONDecoder().decode(Model.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Model
//struct Model1: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let header: Header
//    let body: Body
//}
//
//// MARK: - Body
//struct Body: Codable {
//    let items: Items
//    let numOfRows, pageNo, totalCount: Int
//}
//
//// MARK: - Items
//struct Items: Codable {
//    let item: Any
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let endnodenm: String
//    let endvehicletime: Endvehicletime?
//    let routeid: String
//    let routeno: Endvehicletime
//    let routetp, startnodenm: String
//    let startvehicletime: String?
//}
//
//enum Endvehicletime: Codable {
//    case integer(Int)
//    case string(String)
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Int.self) {
//            self = .integer(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        throw DecodingError.typeMismatch(Endvehicletime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Endvehicletime"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .integer(let x):
//            try container.encode(x)
//        case .string(let x):
//            try container.encode(x)
//        }
//    }
//}
//
//// MARK: - Header
//struct Header: Codable {
//    let resultCode, resultMsg: String
//}
