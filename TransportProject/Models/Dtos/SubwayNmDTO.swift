// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subwayNmDTO = try? JSONDecoder().decode(SubwayNmDTO.self, from: jsonData)

import Foundation

// MARK: - SubwayNmDTO
struct SubwayNmDTO: Codable {
    let datas: [SubwayNmData]

    enum CodingKeys: String, CodingKey {
        case datas = "Data"
    }
}

// MARK: - Datum
struct SubwayNmData: Codable {
    let subwayID, statnID: Int
    let statnNm: String
    let subwayNm: SubwayNm

    enum CodingKeys: String, CodingKey {
        case subwayID = "SUBWAY_ID"
        case statnID = "STATN_ID"
        case statnNm = "STATN_NM"
        case subwayNm = "SUBWAY_NM"
    }
    
    func getModel() -> SubwayNmModel {
        return SubwayNmModel(subwayID: self.subwayID, statnID: self.statnID, statnNm: self.statnNm, subwayNm: self.subwayNm)
    }
    
    
}


