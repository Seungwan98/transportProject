//
//  SubwayArriveModel.swift
//  TransportProject
//
//  Created by 양승완 on 7/8/24.
//

import Foundation

struct SubwayArriveModel {
    let beginRow, endRow, curPage, pageRow: JSONNull?
    let totalCount, rowNum, selectedCount: Int
    let subwayID: String
    let subwayNm: JSONNull?
    let updnLine: UpdnLine
    let trainLineNm: String
    let subwayHeading: JSONNull?
    let statnFid, statnTid, statnTnm, statnID, statnNm: String
    let trainCo: JSONNull?
    let trnsitCo, ordkey, subwayList, statnList: String
    let btrainSttus: BtrainSttus
    let barvlDt, btrainNo, bstatnID, bstatnNm: String
    let recptnDt, arvlMsg2, arvlMsg3, arvlCD: String
    let lstcarAt: String
   
    
}
