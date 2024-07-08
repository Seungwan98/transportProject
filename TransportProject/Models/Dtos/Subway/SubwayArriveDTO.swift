// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let subwayArriveDTO = try? JSONDecoder().decode(SubwayArriveDTO.self, from: jsonData)

import Foundation

// MARK: - SubwayArriveDTO
struct SubwayArriveDTO: Codable {
    let errorMessage: ErrorMessage
    let realtimeArrivalList: [SubwayArriveData]
}


// MARK: - RealtimeArrivalList
struct SubwayArriveData: Codable {
    let beginRow, endRow, curPage, pageRow: JSONNull?
    let totalCount, rowNum, selectedCount: Int
    let subwayID: String
    let subwayNm: JSONNull?
    let updnLine: UpdnLine
    let trainLineNm: String
    let subwayHeading: JSONNull?
    let statnFid, statnTid, statnID, statnNm: String
    let trainCo: JSONNull?
    let trnsitCo, ordkey, subwayList, statnList: String
    let btrainSttus: BtrainSttus
    let barvlDt, btrainNo, bstatnID, bstatnNm: String
    let recptnDt, arvlMsg2, arvlMsg3, arvlCD: String
    let lstcarAt: String

    enum CodingKeys: String, CodingKey {
        case beginRow, endRow, curPage, pageRow, totalCount, rowNum, selectedCount
        case subwayID = "subwayId"
        case subwayNm, updnLine, trainLineNm, subwayHeading, statnFid, statnTid
        case statnID = "statnId"
        case statnNm, trainCo, trnsitCo, ordkey, subwayList, statnList, btrainSttus, barvlDt, btrainNo
        case bstatnID = "bstatnId"
        case bstatnNm, recptnDt, arvlMsg2, arvlMsg3
        case arvlCD = "arvlCd"
        case lstcarAt
    }

    
    
    func getModel() -> SubwayArriveModel {
        return SubwayArriveModel.init(beginRow: self.beginRow, endRow: self.endRow, curPage: self.curPage, pageRow: self.pageRow, totalCount: self.totalCount, rowNum: self.rowNum, selectedCount: self.selectedCount, subwayID: self.subwayID, subwayNm: self.subwayNm, updnLine: self.updnLine, trainLineNm: self.trainLineNm, subwayHeading: self.subwayHeading, statnFid: self.statnFid, statnTid: self.statnTid, statnID: self.statnID, statnNm: self.statnNm, trainCo: self.trainCo, trnsitCo: self.trnsitCo, ordkey: self.ordkey, subwayList: self.subwayList, statnList: self.statnList, btrainSttus: self.btrainSttus, barvlDt: self.barvlDt, btrainNo: self.btrainNo, bstatnID: self.bstatnID, bstatnNm: self.bstatnNm, recptnDt: self.recptnDt, arvlMsg2: self.arvlMsg2, arvlMsg3: self.arvlMsg3, arvlCD: self.arvlCD, lstcarAt: self.lstcarAt)
    }
}

enum BtrainSttus: String, Codable {
    case itx = "ITX"
    case 급행 = "급행"
    case 일반 = "일반"
    case 특급 = "특급"
}

enum UpdnLine: String, Codable {
    case 내선 = "내선"
    case 상행 = "상행"
    case 외선 = "외선"
    case 하행 = "하행"
}

