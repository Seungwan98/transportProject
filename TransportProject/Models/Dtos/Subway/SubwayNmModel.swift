//
//  SubwayNmModel.swift
//  TransportProject
//
//  Created by 양승완 on 7/3/24.
//

import Foundation

struct SubwayNmModel: Identifiable, Equatable {
    var id = UUID()

    let subwayID, statnID: Int
    let statnNm: String
    let subwayNm: SubwayNm

    enum CodingKeys: String, CodingKey {
        case subwayID = "SUBWAY_ID"
        case statnID = "STATN_ID"
        case statnNm = "STATN_NM"
        case subwayNm = "SUBWAY_NM"
    }
}
